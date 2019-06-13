library standas.src.config;

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_jael/angel_jael.dart';
import 'package:file/file.dart';

/// This is a perfect place to include configuration and load plug-ins.
AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    // Configure our application to render Jael templates from the `views/` directory.
    //
    // See: https://github.com/angel-dart/jael
    await app.configure(jael(fileSystem.directory('views')));
  };
}
