import 'package:flutter/material.dart';
import 'package:flutterappdatabasenewsapp/bloc/contact_bloc.dart';
import 'package:flutterappdatabasenewsapp/model/personModel.dart';
import 'package:flutterappdatabasenewsapp/repo/contact_repository.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  TodoRepository repo = new TodoRepository();
  final landlineController = TextEditingController();
  final ContactBloc todoBloc = ContactBloc();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Contact'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                    decoration:
                        new InputDecoration.collapsed(hintText: 'Enter Name'),
                    controller: nameController),
                TextField(
                  controller: mobileController,
                  decoration:
                      new InputDecoration.collapsed(hintText: 'Enter Mobile'),
                ),
                TextField(
                  controller: landlineController,
                  decoration: InputDecoration.collapsed(hintText: 'Enter Landline'),
                ),
              ])),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          final newTodo = Person();
          if (newTodo.name.isNotEmpty) {
            /*Create new Todo object and make sure
                                    the Todo description is not empty,
                                    because what's the point of saving empty
                                    Todo
                                    */
            todoBloc.addPerson(newTodo);

            //dismisses the bottomsheet
//            Navigator.pop(context);
            return dialog(context, "Contact Saved!");

          }
          return dialog(context, "Not Saved");
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.check),
      ),
    );
  }

  Future dialog(BuildContext context, String msg) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          content: Text(msg),
        );
      },
    );
  }
}
