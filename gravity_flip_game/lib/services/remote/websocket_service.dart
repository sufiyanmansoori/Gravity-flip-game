import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketService({required this._url});

  final String _url;
  WebSocketChannel? _channel;
  final StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>.broadcast();

  bool get isConnected => _channel != null;

  Stream<Map<String, dynamic>> get messages => _controller.stream;

  void connect() {
    if (_channel != null) return;

    _channel = WebSocketChannel.connect(Uri.parse(_url));
    _channel!.stream.listen(
      (event) {
        try {
          final decoded = event is String ? event : event.toString();
          final parsed = decoded.isEmpty
              ? <String, dynamic>{}
              : _decode(decoded);
          _controller.add(parsed);
        } catch (_) {
          _controller.add({'raw': event});
        }
      },
      onError: (Object error) {
        _controller.add({'error': error.toString()});
      },
      onDone: () {
        _channel = null;
        _controller.add({'event': 'closed'});
      },
    );
  }

  void send(Map<String, dynamic> payload) {
    if (_channel == null) {
      throw StateError('WebSocket is not connected.');
    }
    _channel!.sink.add(payload);
  }

  void sendText(String text) {
    if (_channel == null) {
      throw StateError('WebSocket is not connected.');
    }
    _channel!.sink.add(text);
  }

  Future<void> close() async {
    await _channel?.sink.close();
    _channel = null;
    await _controller.close();
  }

  Map<String, dynamic> _decode(String payload) {
    final decoded = payload.trim();
    if (decoded.isEmpty) {
      return <String, dynamic>{};
    }

    try {
      final dynamic result = __parseJson(decoded);
      if (result is Map) {
        return Map<String, dynamic>.from(result);
      }
      return {'value': result};
    } catch (_) {
      return {'raw': decoded};
    }
  }

  dynamic __parseJson(String payload) {
    return payload.startsWith('{') || payload.startsWith('[')
        ? _decodeJson(payload)
        : payload;
  }

  dynamic _decodeJson(String payload) {
    // ignore: avoid_dynamic_calls
    return dynamic;
  }
}
