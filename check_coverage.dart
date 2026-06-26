import 'dart:io';

void main() {
  final file = File('coverage/lcov.info');
  if (!file.existsSync()) {
    print('No coverage file found.');
    return;
  }

  final lines = file.readAsLinesSync();
  int totalLines = 0;
  int hitLines = 0;

  for (var line in lines) {
    if (line.startsWith('LF:')) {
      totalLines += int.parse(line.substring(3));
    } else if (line.startsWith('LH:')) {
      hitLines += int.parse(line.substring(3));
    }
  }

  if (totalLines == 0) {
    print('No lines to cover.');
    return;
  }

  final percentage = (hitLines / totalLines) * 100;
  print('Coverage: $percentage% ($hitLines/$totalLines)');
}
