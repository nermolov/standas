import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

// TODO: verify config validity

Future<dynamic> loadConfig() async {
  return jsonDecode(await (File(p.normalize(p.dirname(Platform.script.toFilePath()) + '/../config.json'))).readAsString());
}