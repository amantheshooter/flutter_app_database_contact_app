import 'dart:async';

import 'package:flutterappdatabasenewsapp/database/database.dart';
import 'package:flutterappdatabasenewsapp/model/personModel.dart';

class PersonDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Person records
  Future<int> createPerson(Person contact) async {
    final db = await dbProvider.database;
    var result = db.insert(personTABLE, contact.toDatabaseJson());
    return result;
  }

  //Get All Person items
  //Searches if query string was passed
  Future<List<Person>> getPerson({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(personTABLE,
            columns: columns,
            where: 'id LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(personTABLE, columns: columns);
    }

    List<Person> contacts = result.isNotEmpty
        ? result.map((item) => Person.fromDatabaseJson(item)).toList()
        : [];
    return contacts;
  }

  //Update Person record
  Future<int> updatePerson(Person contact) async {
    final db = await dbProvider.database;

    var result = await db.update(personTABLE, contact.toDatabaseJson(),
        where: "id = ?", whereArgs: [contact.id]);

    return result;
  }

  //Delete Person records
  Future<int> deletePerson(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(personTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllPerson() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      personTABLE,
    );
    return result;
  }
}
