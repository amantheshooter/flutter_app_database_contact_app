import 'dart:async';

import '../database/database.dart';
import '../model/newsModel.dart';

class PersonDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Person records
  Future<int> createPerson(Person todo) async {
    final db = await dbProvider.database;
    var result = db.insert(personTABLE, todo.toDatabaseJson());
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
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(personTABLE, columns: columns);
    }

    List<Person> todos = result.isNotEmpty
        ? result.map((item) => Person.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  //Update Person record
  Future<int> updatePerson(Person todo) async {
    final db = await dbProvider.database;

    var result = await db.update(personTABLE, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);

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
