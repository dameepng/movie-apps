import 'dart:io';

void main() async {
  final dir = Directory('lib/presentation/pages');
  if (!dir.existsSync()) return;

  final files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  for (final file in files) {
    String content = await file.readAsString();
    bool modified = false;

    // Fix 1: ROUTE_NAME -> routeName
    if (content.contains('ROUTE_NAME')) {
      content = content.replaceAll('ROUTE_NAME', 'routeName');
      modified = true;
    }

    // Fix 2: _PrivateState createState() -> State<PublicWidget> createState()
    final createRegex = RegExp(r'_([A-Za-z0-9_]+)State\s+createState\(\)');
    if (createRegex.hasMatch(content)) {
      content = content.replaceAllMapped(createRegex, (match) {
        final widgetName = match.group(1);
        return 'State<$widgetName> createState()';
      });
      modified = true;
    }

    // Fix 3: Future.microtask(() => Provider.of...) -> Future.microtask(() { if (!mounted) return; Provider.of... })
    // It's safer to just inject if (!mounted) return; if we detect Future.microtask(() => Provider.of
    final microtaskRegex = RegExp(
        r'Future\.microtask\(\(\)\s*=>\s*Provider\.of<([A-Za-z0-9_<>]+)>\(context,\s*listen:\s*false\)\s*\.\.([A-Za-z0-9_]+)\(\)\);');
    if (microtaskRegex.hasMatch(content)) {
      content = content.replaceAllMapped(microtaskRegex, (match) {
        return '''Future.microtask(() {
      if (!mounted) return;
      Provider.of<${match.group(1)}>(context, listen: false)..${match.group(2)}();
    });''';
      });
      modified = true;
    }

    // Some providers use .fetch() instead of cascade ..fetch()
    final microtaskRegex2 = RegExp(
        r'Future\.microtask\(\(\)\s*=>\s*Provider\.of<([A-Za-z0-9_<>]+)>\(context,\s*listen:\s*false\)\s*\.([A-Za-z0-9_]+)\((.*)\)\);');
    if (microtaskRegex2.hasMatch(content)) {
      content = content.replaceAllMapped(microtaskRegex2, (match) {
        return '''Future.microtask(() {
      if (!mounted) return;
      Provider.of<${match.group(1)}>(context, listen: false).${match.group(2)}(${match.group(3)});
    });''';
      });
      modified = true;
    }

    if (modified) {
      await file.writeAsString(content);
      print('Fixed \${file.path}');
    }
  }

  // Also fix main.dart for routeName
  final mainFile = File('lib/main.dart');
  if (mainFile.existsSync()) {
    String mainContent = await mainFile.readAsString();
    if (mainContent.contains('ROUTE_NAME')) {
      mainContent = mainContent.replaceAll('ROUTE_NAME', 'routeName');
      await mainFile.writeAsString(mainContent);
      print('Fixed main.dart');
    }
  }
}
