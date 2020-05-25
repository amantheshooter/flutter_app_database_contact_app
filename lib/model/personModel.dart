class Person {
  int id;
  //description is the text we see on
  //main screen card text
  String name;
  String landLine;
  String mobile;
  //isDone used to mark what Todo item is completed
  bool isDone = false;

  //When using curly braces { } we note dart that
  //the parameters are optional
  Person({this.id, this.name, this.mobile, this.landLine,this.isDone = false});


  factory Person.fromDatabaseJson(Map<String, dynamic> data) => Person(
    //Factory method will be used to convert JSON objects that
    //are coming from querying the database and converting
    //it into a Contact object

    id: data['id'],
    name: data['name'],
    mobile: data['mobile'],
    landLine: data['landLine'],

    //Since sqlite doesn't have boolean type for true/false,
    //we will use 0 to denote that it is false
    //and 1 for true
    isDone: data['is_done'] == 0 ? false : true,
  );

  Map<String, dynamic> toDatabaseJson() => {
    //A method will be used to convert Todo objects that
    //are to be stored into the datbase in a form of JSON

    "id": this.id,
    "name": this.name,
    "mobile": this.mobile,
    "landLine": this.landLine,
    "is_done": this.isDone == false ? 0 : 1,
  };
}
