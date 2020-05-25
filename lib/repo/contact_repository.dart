import 'package:flutterappdatabasenewsapp/dao/contact_dao.dart';
import 'package:flutterappdatabasenewsapp/model/personModel.dart';

class ContactRepository {
  final contactDao = PersonDao();

  Future getAllContacts({String query}) => contactDao.getPerson(query: query);

  Future insertContact(Person contact) => contactDao.createPerson(contact);

  Future updateContact(Person contact) => contactDao.updatePerson(contact);

  Future deleteContactById(int id) => contactDao.deletePerson(id);

  //We are not going to use this in the demo
  Future deleteAllContacts() => contactDao.deleteAllPerson();
}
