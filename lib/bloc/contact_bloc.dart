
import 'dart:async';

import 'package:flutterappdatabasenewsapp/model/personModel.dart';
import 'package:flutterappdatabasenewsapp/repo/contact_repository.dart';

class ContactBloc {
  //Get instance of the Repository
  final _contactRepository = ContactRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _todoController = StreamController<List<Person>>.broadcast();

  get contacts => _todoController.stream;

  ContactBloc() {
    getPerson();
  }

  getPerson({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _todoController.sink.add(await _contactRepository.getAllContacts(query: query));
  }

  addPerson(Person todo) async {
    await _contactRepository.insertContact(todo);
    getPerson();
  }

  updatePerson(Person todo) async {
    await _contactRepository.updateContact(todo);
    getPerson();
  }

  deleteTodoById(int id) async {
    _contactRepository.deleteContactById(id);
    getPerson();
  }

  dispose() {
    _todoController.close();
  }
}