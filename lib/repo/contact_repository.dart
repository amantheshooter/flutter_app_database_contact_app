import 'package:flutterappdatabasenewsapp/dao/contact_dao.dart';
import 'package:flutterappdatabasenewsapp/model/personModel.dart';

class TodoRepository {
  final todoDao = PersonDao();

  Future getAllTodos({String query}) => todoDao.getPerson(query: query);

  Future insertTodo(Person todo) => todoDao.createPerson(todo);

  Future updateTodo(Person todo) => todoDao.updatePerson(todo);

  Future deleteTodoById(int id) => todoDao.deletePerson(id);

  //We are not going to use this in the demo
  Future deleteAllTodos() => todoDao.deleteAllPerson();
}
