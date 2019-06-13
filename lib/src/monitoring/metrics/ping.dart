import 'package:dart_ping/dart_ping.dart' as pinglib;

import '../core.dart';

class PingTest {
  Stream<pinglib.PingInfo> _pingStream;
  String _hostname;
  String _title;
  Duration _timeout;
  DateTime _lastPingStamp;
  pinglib.PingInfo _lastInfo;

  bool get _timedOut => _lastPingStamp == null || DateTime.now().difference(_lastPingStamp) > _timeout;

  PingTest(this._hostname, {Duration timeout = const Duration(seconds: 15), String title = 'Response time'}) {
    _timeout = timeout;
    _title = title;
    startStream();
  }

  Future<void> startStream() async {
    // TODO: error handling
    // dns failure
    // other stuff
    // TODO: try restarting if dns doesn't resolve
    _pingStream = await pinglib.ping(_hostname);
    await for (pinglib.PingInfo ping in _pingStream) {
      _lastPingStamp = DateTime.now();
      _lastInfo = ping;
    }
  }

  String get value => _timedOut ? 'Timed out' : _lastInfo.time.inMilliseconds.toString() + ' ms';
  String get color => getColor(_timedOut ? StatusColor.red : StatusColor.green);
  String get title => _title;
}