import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdatabasenewsapp/bloc/contact_bloc.dart';
import 'package:flutterappdatabasenewsapp/model/personModel.dart';
import 'package:flutterappdatabasenewsapp/ui/MyCustomForm.dart';

class HomePage extends StatelessWidget {
  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  ContactBloc contactBloc = new ContactBloc();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Add New Contact'),
      ),
      body: SafeArea(
          child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
              child: Container(
                  //This is where the magic starts
                  child: getContactWidget()))),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyCustomForm(null)));
        },
        tooltip: 'Add Contact',
        child: Icon(Icons.add),
      ),
    );
  }

  getContactWidget() {
    return StreamBuilder(
      stream: contactBloc.contacts,
      builder: (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
        return getContactCardWidget(snapshot);
      },
    );
  }

  getContactCardWidget(AsyncSnapshot<List<Person>> snapshot) {
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of Todo from DB.
      If that the case show user that you have empty Todos
      */
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                Person contact = snapshot.data[itemPosition];
                final Widget dismissibleCard = new Dismissible(
                    background: Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Deleting",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      color: Colors.redAccent,
                    ),
                    onDismissed: (direction) {
                      /*The magic
                    delete Todo item by ID whenever
                    the card is dismissed
                    */
                      contactBloc.deleteTodoById(contact.id);
                    },
                    direction: _dismissDirection,
                    key: new ObjectKey(contact),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[200], width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: ListTile(
                          title: Text(
                            contact.name,
                            style: TextStyle(
                                fontSize: 16.5,
                                fontFamily: 'RobotoMono',
                                fontWeight: FontWeight.w500,
                                decoration: contact.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          onTap: () {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                  builder: (context) => MyCustomForm(contact),
//                                ));
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(contact.toDatabaseJson().toString())));
                          }),
                    ));
                return dismissibleCard;
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Todo
              //in the data base
              child: noTodoMessageWidget(),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    //pull todos again
    contactBloc.getPerson();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noTodoMessageWidget() {
    return Container(
      child: Text(
        "Start adding Todo...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
