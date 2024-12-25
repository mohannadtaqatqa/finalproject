// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class Sqldb {
//   static Database? _db;

//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await initializeDb();
//       return _db;
//     } else {
//       return _db;
//     }
//   }

//   Future<Database> initializeDb() async {
//     String pathDB = await getDatabasesPath();
//     String path = join(pathDB, "feeds.db");
//     Database database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: onCreate,
//     );
//     return database;
//   }

//   Future<void> onCreate(Database db, int version) async {
//     await db.execute('''
//         CREATE TABLE "feedstoken"(
//             "id" INTEGER PRIMARY KEY AUTOINCREMENT,
//             "token" TEXT NOT NULL
//         )
//     ''');
//   }

//   Future<List<Map<String, dynamic>>> readData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawQuery(sql);
//   }

//   Future<int> insertData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawInsert(sql);
//   }

//   Future<int> updateData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawUpdate(sql);
//   }

//   Future<int> deleteData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawDelete(sql);
//   }
// }
////////////////////////////////////////////correct code |||||||/////////
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? _db ; 
  
  Future<Database?> get db async {
      if (_db == null){
        _db  = await intialDb() ;
        return _db ;  
      }else {
        return _db ; 
      }
  }


intialDb() async {
  String databasepath = await getDatabasesPath() ; 
  String path = join(databasepath , 'ppu.db') ;   
  Database mydb = await openDatabase(path , onCreate: _onCreate , version: 1  , onUpgrade:_onUpgrade ) ;  
  return mydb ; 
}

_onUpgrade(Database db , int oldversion , int newversion ) {


 print("onUpgrade =====================================") ; 
  
}

_onCreate(Database db , int version) async {
  await db.execute('''
  CREATE TABLE "feeds" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "token" TEXT NOT NULL
  )
 ''') ;
 print(" onCreate =====================================") ; 

}

readData(String sql) async {
  Database? mydb = await db ; 
  List<Map> response = await  mydb!.rawQuery(sql);
  return response ; 
}
insertData(String sql) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.rawInsert(sql);
  return response ; 
}
// updateData(String sql) async {
//   Database? mydb = await db ; 
//   int  response = await  mydb!.rawUpdate(sql);
//   return response ; 
// }
deleteData(String sql) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.rawDelete(sql);
  return response ; 
}
 

}


// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class Sqldb {
//   static Database? _db;

//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await initializeDb();
//       return _db;
//     } else {
//       return _db;
//     }
//   }

//   Future<Database> initializeDb() async {
//     String pathDB = await getDatabasesPath();
//     String path = join(pathDB, "feeds.db");
//     Database database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: onCreate,
//     );
//     return database;
//   }

//   Future<void> onCreate(Database db, int version) async {
//     await db.execute('''
//         CREATE TABLE "feedstoken"(
//             "id" INTEGER PRIMARY KEY,
//             "token" TEXT NOT NULL
//         )
//     ''');
//   }

//   Future<List<Map<String, dynamic>>> readData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawQuery(sql);
//   }

//   Future<int> insertToken(int id, String token) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.insert(
//       'feedstoken',
//       {
//         'id': id,
//         'token': token,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<int> updateData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawUpdate(sql);
//   }

//   Future<int> deleteData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawDelete(sql);
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class Sqldb {
//   static Database? _db;

//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await initializeDb();
//       return _db;
//     } else {
//       return _db;
//     }
//   }

//   Future<Database> initializeDb() async {
//     String pathDB = await getDatabasesPath();
//     String path = join(pathDB, "feeds.db");
//     Database database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: onCreate,
//     );
//     return database;
//   }

//   Future<void> onCreate(Database db, int version) async {
//     await db.execute('''
//         CREATE TABLE "feedstoken"(
//             "id" INTEGER PRIMARY KEY,
//             "token" TEXT NOT NULL
//         )
//     ''');
//   }

//   Future<List<Map<String, dynamic>>> readData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawQuery(sql);
//   }

//   // Future<int> insertToken(int id, String token) async {
//   //   Database? database = await db;
//   //   if (database == null) throw Exception("Database is not initialized.");

//   //   return await database.insert(
//   //     'feedstoken',
//   //     {
//   //       'id': id,
//   //       'token': token,
//   //     },
//   //     conflictAlgorithm: ConflictAlgorithm.replace,
//   //   );
//   // }


// Future<int> insertToken(int id, String token) async {
//   final database = await db; // Ensure the database is initialized
//   try {
//     return await database!.insert(
//       'feedstoken',
//       {'id': id, 'token': token},
//       conflictAlgorithm: ConflictAlgorithm.replace, // Replace if the ID already exists
//     );
//   } catch (e) {
//     debugPrint('Error inserting token: $e'); // Log errors for debugging
//     return -1; // Return error indicator
//   }
// }

//   Future<String?> getToken() async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     final List<Map<String, dynamic>> result = await database.query(
//       'feedstoken',
//       columns: ['token'],
//       limit: 1,
//     );

//     if (result.isNotEmpty) {
//       return result.first['token'] as String?;
//     }
//     return null; // No token found
//   }

//   Future<int> updateData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawUpdate(sql);
//   }

//   Future<int> deleteData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawDelete(sql);
//   }
// }





// import 'dart:io'; // For Platform check
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // For desktop/testing environments
// import 'package:path/path.dart';

// class Sqldb {
//   static Database? _db;

//   // Constructor to initialize the correct database factory if needed
//   Sqldb() {
//     if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
//       // Set databaseFactory for desktop environments
//       databaseFactory = databaseFactoryFfi;
//     }
//   }

//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await initializeDb();
//       return _db;
//     } else {
//       return _db;
//     }
//   }

//   Future<Database> initializeDb() async {
//     String pathDB = await getDatabasesPath();
//     String path = join(pathDB, "feeds.db");
//     Database database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: onCreate,
//     );
//     return database;
//   }

//   Future<void> onCreate(Database db, int version) async {
//     await db.execute('''
//         CREATE TABLE "feedstoken"(
//             "id" INTEGER PRIMARY KEY,
//             "token" TEXT NOT NULL
//         )
//     ''');
//   }

//   Future<List<Map<String, dynamic>>> readData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawQuery(sql);
//   }

//   Future<int> insertToken(int id, String token) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.insert(
//       'feedstoken',
//       {
//         'id': id,
//         'token': token,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<String?> getToken() async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     final List<Map<String, dynamic>> result = await database.query(
//       'feedstoken',
//       columns: ['token'],
//       limit: 1,
//     );

//     if (result.isNotEmpty) {
//       return result.first['token'] as String?;
//     }
//     return null; // No token found
//   }

//   Future<int> updateData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawUpdate(sql);
//   }

//   Future<int> deleteData(String sql) async {
//     Database? database = await db;
//     if (database == null) throw Exception("Database is not initialized.");

//     return await database.rawDelete(sql);
//   }
// }
