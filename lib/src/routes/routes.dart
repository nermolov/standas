library standas.src.routes;

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_static/angel_static.dart';
import 'package:file/file.dart';

import '../monitoring/core.dart';
import '../../standas.dart';

/// Put your app routes here!
///
/// See the wiki for information about routing, requests, and responses:
/// * https://github.com/angel-dart/angel/wiki/Basic-Routing
/// * https://github.com/angel-dart/angel/wiki/Requests-&-Responses
AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    // Render `views/hello.jl` when a user visits the application root.
    app.get('/', (req, res) => res.render('index', {'sites': siteData, 'config': globalConfig}));

    // serve static files
    var vDir = VirtualDirectory(
      app,
      fileSystem,
      source: fileSystem.directory('web'),
    );
    app.fallback(vDir.handleRequest);

    // Throw a 404 if no route matched the request.
    app.fallback((req, res) => throw AngelHttpException.notFound());

    // Set our application up to handle different errors.
    //
    // Read the following for documentation:
    // * https://github.com/angel-dart/angel/wiki/Error-Handling

    var oldErrorHandler = app.errorHandler;
    app.errorHandler = (e, req, res) async {
      if (req.accepts('text/html', strict: true)) {
        await res.render('error', {'message': e.message, 'config': globalConfig});
      } else {
        return await oldErrorHandler(e, req, res);
      }
    };
  };
}
