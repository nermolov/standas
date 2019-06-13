# standas

a status page written in dart

![screenshot](https://github.com/nermolov/standas/raw/master/screenshot.png)

## usage

* edit config
* `pub get`
* `dart bin/prod.dart`

reccomended to place behind a reverse proxy

## todo

### main

* revamp config loading
  * better insertion of arguments during class instantiation
  * validation of config (do this while loading or while initializing monitoring?)
* add alerts (use regular forms)
* add graphs
* write tests
* possibly use angel prod? would have to handle isolates

### metrics

* ping
  * fix error handling
* cert validation
* http check
* mail server checks?