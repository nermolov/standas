import 'dart:async';

import '../../standas.dart';

import 'metrics/ping.dart' as ping;
Map<String, Object> metrics = {
  'ping': ping.PingTest
};

enum StatusColor { red, orange, green }
String getColor(StatusColor color) => color.toString().split('.')[1];

List<Map<String, dynamic>> siteData = [];

void startMonitoring() {
  for (var siteConfig in globalConfig['sites']) {
    Map<String, dynamic> site = {
      'name': siteConfig['name'],
      'metrics': []
    };
    for (var metricConfig in siteConfig['metrics']) {
      // TODO: potential better wau to get options into arguments?
      switch (metricConfig['type']) {
        case 'ping':
          site['metrics'].add(ping.PingTest(metricConfig['address']));
          break;
        default:
          break;
      }
    }
    siteData.add(site);
  }
  print('Monitoring started!');
}