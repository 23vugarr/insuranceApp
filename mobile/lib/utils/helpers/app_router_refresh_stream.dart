import 'dart:async';

import 'package:flutter/foundation.dart';

class AppRouterRefreshStream<T> extends ChangeNotifier {
  late final StreamSubscription<T> _subscription;
  T? _curValue;

  AppRouterRefreshStream(Stream<T> stream, {T? initValue, bool Function(T? curValue, T newValue)? shouldNotify}) {
    notifyListeners();
    _curValue = initValue;
    _subscription = stream.asBroadcastStream().listen((T newValue) {
      if (shouldNotify?.call(_curValue, newValue) ?? true) {
        notifyListeners();
      }
      _curValue = newValue;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _curValue = null;
    super.dispose();
  }
}