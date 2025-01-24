import 'dart:async';

class TimerService {
  Timer? _timer;
  int _elapsedSeconds = 0;
  void Function(TimerService)? onTick;

  TimerService({this.onTick});

  void start() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      _elapsedSeconds++;
      if (onTick != null) {
        onTick!(this);
      }
    });
  }

  void stop() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void reset() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _elapsedSeconds = 0;
  }

  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  int get elapsedSeconds => _elapsedSeconds;
}