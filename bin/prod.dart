import 'package:standas/src/pretty_logging.dart';
import 'package:standas/standas.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:logging/logging.dart';
import 'package:angel_framework/http.dart';

main() async {
  hierarchicalLoggingEnabled = true;
  var logger = Logger.detached('standas')
    ..level = Level.ALL
    ..onRecord.listen(prettyLog);
  var app = Angel(logger: logger, reflector: MirrorsReflector());
  await app.configure(configureServer);
  var http = AngelHttp(app);
  var server = await http.startServer('127.0.0.1', 3000);
  print(
      'standas server listening at http://${server.address.address}:${server.port}');
}
