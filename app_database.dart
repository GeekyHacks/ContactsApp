import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'dart:async';

class AppDatabase {
//the only available instance of this AppDatabase class
//is stored in this private field
  static final AppDatabase _singleton = AppDatabase._();
//this instance get-only property is the only way for other classes to access
//the single appdatabase object
  static AppDatabase get instance => _singleton;

  Future<Database> get database async {
//if completer is null, database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // calling _openDatabase will also complete the completer with
      //database instance
      _openDatabase();
    }

//if database is already opened return immediately
//otherwise wait until complete() is called on the completer in _openDatabase()
    return _dbOpenCompleter!.future;
  }

//completer used for transforming sychronous into asynchronous code
  Completer<Database>? _dbOpenCompleter;
//a private constructpr
//by providing it we can create new instances only from within this sembestdb
//class itself
  AppDatabase._();
// async usually needs future function

  Future _openDatabase() async {
//get a platform specific directory where app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
// generates path with the form: /platform-specific-directory/contacts.db
    final dbPath = join(appDocumentDir.path, 'contacts.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter?.complete(database);
  }
}
