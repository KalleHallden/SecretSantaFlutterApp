import 'package:flutter/material.dart';

void main() => runApp(MyApp());

var greenColor = new Color.fromRGBO(15, 158, 56, 1);
var redColor = new Color.fromRGBO(191, 30, 30, 1);
List<String> members = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo List',
      home: new SecretSantaList()
    );
  }
}

class SecretSantaList extends StatefulWidget {
  @override
  createState() => new MyAppState();
}


class MyAppState extends State<SecretSantaList> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Secret Santa',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Secret Santa'),
          backgroundColor: redColor,
        ),
         body: buildMemberList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: addMember,
        tooltip: 'Add member',
        child: new Icon(Icons.add),
        foregroundColor: greenColor,
        backgroundColor: redColor,
      ),
      ),
    theme: ThemeData(
    // Define the default Brightness and Colors
    brightness: Brightness.light,
    primaryColor: Colors.lightBlue[800],
    accentColor: Colors.yellow[600],
    
    // Define the default Font Family
    fontFamily: 'Avenir next',
    
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: greenColor),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: greenColor),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Avenir heavy', color: greenColor),
    ),
    )
    );
  }
  
  void addMember() {
  
  setState(() {
      int index = members.length;
      members.add('Person ' + index.toString());
    });
}

Widget buildMemberList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if(index < members.length) {
          return buildMember(members[index]);
        }
      },
    );
  }

   Widget buildMember(String todoText) {
    return new ListTile(
      title: new Text(todoText)
    );
  }

}