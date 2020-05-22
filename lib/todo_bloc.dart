import 'package:flutterappdatabasenewsapp/todo_repository.dart';

import 'dart:async';

import 'newsModel.dart';

class TodoBloc {
  //Get instance of the Repository
  final _todoRepository = TodoRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _todoController = StreamController<List<Person>>.broadcast();

  get todos => _todoController.stream;

  TodoBloc() {
    getPerson();
  }

  getPerson({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _todoController.sink.add(await _todoRepository.getAllTodos(query: query));
  }

  addPerson(Person todo) async {
    await _todoRepository.insertTodo(todo);
    getPerson();
  }

  updatePerson(Person todo) async {
    await _todoRepository.updateTodo(todo);
    getPerson();
  }

  deleteTodoById(int id) async {
    _todoRepository.deleteTodoById(id);
    getPerson();
  }

  dispose() {
    _todoController.close();
  }
}