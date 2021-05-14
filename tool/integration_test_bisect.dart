import 'dart:io';

void main() async {
  /// This bisect script assumes that:
  /// * You are on Windows (sorry!)
  /// * The bisect is performed within the working directory of the flutter-to-bisect
  /// * The `integration_test_bisect` package is outside the relative directory.
  final flutterRoot = Directory.current;
  final process = await Process.start(
    '${flutterRoot.path}\\bin\\flutter.bat',
    ['test'],
    workingDirectory: '..\\integration_test_bisect',
  );

  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);

  final code = await process.exitCode;

  print(code);
  exit(code);
}
