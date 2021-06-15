

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:firebase_topico/models/user.dart';

class Dbprovider {

   static Database _database;
   static final Dbprovider db = Dbprovider._();

   Dbprovider._();

   Future<Database> get database async {

       if( _database != null ) return _database;

       _database = await initDB();
       return _database;

   }

   initDB() async {

      Directory documentsDirectory = await getApplicationDocumentsDirectory(); 
      final path = join( documentsDirectory.path , 'topicoDB.db' );
      
      Database dbase = await openDatabase( path , version: 1 , onOpen: (db){} , onCreate: ( Database db, int version )async{

           print("Version de la base de datos " + version.toString());
          await db.execute('CREATE TABLE Usuario ('
              ' ci              TEXT PRIMARY KEY,'
              ' nombre_completo TEXT,'
              ' apellido_completo TEXT,'
              ' celular        TEXT,'
              ' ciudad TEXT'
              ')');


      } , onUpgrade: ( db, oldversion, newversion ) async {}    );
        return dbase;
   }

  Future<int> nuevoUsuarioTwo( Usuario usuario ) async {

      final db = await database;
      var res;
      try {
        res = await db.insert('Usuario', usuario.toJson());
      } catch  (  e ) {
        res = 0;
      }

      return res;

   }




}