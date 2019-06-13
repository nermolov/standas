library standas;

import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:file/local.dart';
import 'src/config/config.dart' as configuration;
import 'src/routes/routes.dart' as routes;
import 'src/config_loader.dart' as config_loader;
import 'src/monitoring/core.dart' as monitor;

dynamic globalConfig;

/// Configures the server instance.
Future configureServer(Angel app) async {
  // Grab a handle to the file system, so that we can do things like
  // serve static files.
  var fs = const LocalFileSystem();

  // load config
  globalConfig = await config_loader.loadConfig();
  // start monitoring
  monitor.startMonitoring();

  // Set up our application, using the plug-ins defined with this project.
  await app.configure(configuration.configureServer(fs));
  await app.configure(routes.configureServer(fs));
}
