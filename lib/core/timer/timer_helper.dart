import 'dart:async';

class CustomTimer {


  late int _totalSeconds;
  late Timer _timer;

  late Function(String) _onTick;
  bool _isFinished = false;

  CustomTimer({required Function(String) onTick,}) {
    _onTick = onTick;
    _totalSeconds = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), _handleTick);
  }

  CustomTimer.withCustomDays({required Function(String) onTick}) {
    _onTick = onTick;
    _totalSeconds = 0; // Set this to true if you want to handle custom day format
    _timer = Timer.periodic(const Duration(seconds: 1), _handleCustomTick);
  }

  void _handleTick(Timer timer) {
    _totalSeconds--;
    if (_totalSeconds <= 0) {
      _timer.cancel();
      _isFinished = true;
    }
    _onTick(_formatTime(_totalSeconds));

  }

  void _handleCustomTick(Timer timer) {
    _totalSeconds--;
    if (_totalSeconds <= 0) {
      _timer.cancel();
      _isFinished = true;
    }
    _onTick(_formatDuration(_totalSeconds));
  }

  String _formatTime(int timeInSeconds) {

    int seconds = timeInSeconds % 60;
    return '00 : ${seconds.toString().padLeft(1, '0')}';
  }

  String _formatDuration(int totalSeconds) {
    int days = totalSeconds ~/ (24 * 3600);
    totalSeconds %= (24 * 3600);
    int hours = totalSeconds ~/ 3600;
    totalSeconds %= 3600;
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(days)} : ${twoDigits(hours)} : ${twoDigits(
        minutes)} : ${twoDigits(seconds)}";
  }
  void start(int seconds) {
    _totalSeconds = seconds;
    _isFinished = false;
    _onTick(_formatTime(_totalSeconds));
  }

  void startCustomTime(int seconds) {
    _totalSeconds = seconds;
    _isFinished = false;
    _onTick(_formatDuration(_totalSeconds));
  }


  void restart(int seconds) {
    _timer.cancel();
    _isFinished = false;
    start(seconds);
    _timer = Timer.periodic(const Duration(seconds: 1), _handleTick);
  }



  void restartCustomTime(int seconds) {
    _timer.cancel();
    _isFinished = false;
    startCustomTime(seconds);
    _timer = Timer.periodic(const Duration(seconds: 1), _handleCustomTick);
  }

  bool get isFinished => _isFinished;

  void dispose() {
    _timer.cancel();
  }
}

