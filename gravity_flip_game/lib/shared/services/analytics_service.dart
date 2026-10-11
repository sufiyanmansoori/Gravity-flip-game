import 'package:flutter/foundation.dart';

class AnalyticsService extends ChangeNotifier {
  AnalyticsService();

  final Map<String, dynamic> _eventQueue = <String, dynamic>{};

  void track(String eventName, {Map<String, dynamic>? properties}) {
    final payload = <String, dynamic>{
      'event': eventName,
      'timestamp': DateTime.now().toIso8601String(),
      'properties': ?properties,
    };
    _eventQueue[eventName] = payload;
    notifyListeners();
  }

  Map<String, dynamic> flush() {
    final snapshot = Map<String, dynamic>.from(_eventQueue);
    _eventQueue.clear();
    return snapshot;
  }
}
