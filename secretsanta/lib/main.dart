import 'package:flutter/material.dart';

void main() => runApp(MyApp());

var greenColor = new Color.fromRGBO(15, 158, 56, 1);
var redColor = new Color.fromRGBO(191, 30, 30, 1);
List<String> members = [];
var guess = new Map();

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
        backgroundColor: redColor,
        appBar: new AppBar(
          title: new Text('Secret Santa'),
          backgroundColor: redColor,
          textTheme: TextTheme(title: TextStyle(
            fontSize: 20,
            fontFamily: "Avenir",
            fontWeight: FontWeight.bold,
            color: Colors.white
          )),
          actions: <Widget>[
            startButton()
          ],
          
        ),
        body: 
          buildMemberList(),      
          floatingActionButton: new FloatingActionButton(
          tooltip: 'Add member',
          onPressed: () {
            for (String member in members) {
              pushStartToScreen(member);
            }
          },
             
        
        child: new Icon(Icons.play_arrow),
        foregroundColor: redColor,
        backgroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    theme: ThemeData(
    
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
  
  void addMember(String member) {
  
  if (member.length > 0) {
    setState(() {
      members.add(member);
    });
  }
}

Widget startButton() {
  return new FlatButton( 
    child: new Icon(Icons.add, color: Colors.white),
    onPressed: () {
          pushAddTodoScreen();
    },
  );
}

Widget buildMemberList() {
  return new ListView.builder(
           itemBuilder: (context, index) {
            // itemBuilder will be automatically be called as many times as it takes for the
            // list to fill up its available space, which is most likely more than the
            // number of todo items we have. So, we need to check the index is OK.
            if(index < members.length) {
              return buildMember(
                members[index], 
                index
                );
            }
          }
        );
  }

   Widget buildMember(String todoText, int index) {
    return new ListTile(
      title: new Text(
        todoText,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20,
            fontFamily: "Avenir",
            color: Colors.white
          ),
        ),
      onLongPress: () => promptRemoveMember(index),
    );
  }

void pushStartToScreen(String member) {
  // Push this page onto the stack
  Navigator.of(context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
    new MaterialPageRoute (
      builder: (context) {
        return new Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            backgroundColor: redColor,
            title: new Text('Vem tror du att ${member}s present\n är till egentligen?', textAlign: TextAlign.center)
          ),
          body: new TextField(
            autofocus: true,
            style: TextStyle(
            fontSize: 20,
            fontFamily: "Avenir",
            color: redColor
            ),
            onSubmitted: (val) {
              print(val);
              guess[member] = val;
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
              hintText: 'Skriv in namn på deltagare..',
              contentPadding: const EdgeInsets.all(16.0),
              focusedBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: redColor),   
                ),    
            ),
          ),
          floatingActionButton: new FloatingActionButton(

            tooltip: 'Next member',
            onPressed: () {
            Navigator.pop(context);// Close the add todo screen
          },
             
        
        child: new Icon(Icons.arrow_forward),
        foregroundColor: Colors.white,
        backgroundColor: redColor,

          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      }
    )
  );
}

void pushAddTodoScreen() {
  // Push this page onto the stack
  Navigator.of(context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
    new MaterialPageRoute (
      builder: (context) {
        return new Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            backgroundColor: redColor,
            title: new Text('Lägg till en deltagare')
          ),
          body: new TextField(
            autofocus: true,
            style: TextStyle(
            fontSize: 20,
            fontFamily: "Avenir",
            color: redColor
            ),
            onSubmitted: (val) {
              addMember(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
              hintText: 'Skriv in namn på deltagare..',
              contentPadding: const EdgeInsets.all(16.0),
              focusedBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: redColor),   
                ),    
            ),
          ),
        );
      }
    )
  );
}

void removeMember(int index) {
  setState(() => members.removeAt(index));
}

// Show an alert dialog asking the user to confirm that the task is done
void promptRemoveMember(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Vill du ta bort ${members[index]} från listan?', style: TextStyle(
              fontSize: 20,
              fontFamily: "Avenir",
              fontWeight: FontWeight.bold,
              color: greenColor
              ),
            ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('avbryt', style: TextStyle(
              fontSize: 20,
              fontFamily: "Avenir",
              color: redColor
              ),
            ),
            onPressed: () => Navigator.of(context).pop()
          ),
          new FlatButton(
            child: new Text('delete', style: TextStyle(
              fontSize: 20,
              fontFamily: "Avenir",
              fontWeight: FontWeight.bold,
              color: redColor
              ),
            ),
            onPressed: () {
              removeMember(index);
              Navigator.of(context).pop();
            }
          ),
        ]
      );
    }
  );
}

}