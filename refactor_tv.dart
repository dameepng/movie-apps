import 'dart:io';

void main() async {
  final directories = [Directory('lib'), Directory('test')];
  int modifiedFilesCount = 0;

  for (final dir in directories) {
    if (!dir.existsSync()) continue;
    final files = dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));

    for (final file in files) {
      String content = await file.readAsString();

      if (content.contains('Tv')) {
        // Find and replace exactly 'Tv' (case-sensitive) with 'TV'
        content = content.replaceAll('Tv', 'TV');
        await file.writeAsString(content);
        print('Refactored: \${file.path}');
        modifiedFilesCount++;
      }
    }
  }

  print('Successfully refactored \$modifiedFilesCount files!');
}
