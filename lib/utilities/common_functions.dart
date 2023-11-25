/// Delays the execution for a given number of seconds.
Future<void> fakeDelay(int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
}
