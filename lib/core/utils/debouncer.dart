import 'dart:async';

class Debouncer {
  Timer? _timer;

  Debouncer();

  call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), callback);
  }

  dispose() {
    _timer?.cancel();
  }
}
