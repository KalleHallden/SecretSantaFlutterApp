import 'package:flutter/material.dart';

void main() => runApp(MyApp());

var greenColor = new Color.fromRGBO(15, 158, 56, 1);
var redColor = new Color.fromRGBO(191, 30, 30, 1);
List<Member> members = [];
var textStyleRedLarge = TextStyle(
                  fontSize: 30,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.bold,
                  color: redColor,
                  );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo List',
      home: new SecretSantaList()
    );
  }
}

class Member {
  String name;
  Present present;

  Member(String name, Present present) {
    this.name = name;
    this.present = present;
  }
}

 class Present {
  Present() {
    print("New present was made");
  }
  var listOfGuesses = new Map();
  void makeGuess(Member member) {
    if (listOfGuesses.containsKey(member)) {
      var numOfGuesses = listOfGuesses[member];
      listOfGuesses[member] = numOfGuesses += 1;
      print("Another vote for " + member.name);
    } else {
      if (members.contains(member)) {
        print("New member " + member.name + " added to guess list");
        listOfGuesses[member] = 1;
      }
    }
  }

  int getGuessesForMember(Member member) {
    if (listOfGuesses.containsKey(member)) {
      return listOfGuesses[member];
    }
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
          centerTitle: false,
          backgroundColor: redColor,
          textTheme: TextTheme(title: TextStyle(
            fontSize: 20,
            fontFamily: "Avenir",
            fontWeight: FontWeight.bold,
            color: Colors.white
          )),
          actions: <Widget>[
            startButton(),
            getResultButton()
          ],
          
        ),
        body: 
          buildMemberList(),      
          floatingActionButton: new FloatingActionButton(
          tooltip: 'Add member',
          onPressed: () {
            for (Member member in members) {
              pushStartToScreen(member.name);
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
  void addMember(String memberName) {
  if (memberName.length > 0) {
    setState(() {
      Member member = new Member(memberName, new Present());
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
Widget getResultButton() {
  return new FlatButton( 
    child: new Icon(Icons.assessment, color: Colors.white),
    onPressed: () {
          // fo revery member get all guesses in the list
          for (Member member in members) {
            mostNumGuesses = 0;
            pushResultToScreen(member);
            for (Member memberInList in members) {
              String name = memberInList.name;
              int numGuesses = member.present.getGuessesForMember(memberInList);
              int nonNullNum = 0;
              if (numGuesses != null) {
                nonNullNum = numGuesses;
              }
              if (nonNullNum > mostNumGuesses) {
                mostNumGuesses = nonNullNum;
                print("\nMost num of guesses: " + mostNumGuesses.toString());
                listOfMostGuessed[member] = name;
              }
            }
          }
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

  Widget buildResultMemberList(member) {
  return new ListView.builder(
           itemBuilder: (context, index) {
              mostNumGuesses = 0;
            // itemBuilder will be automatically be called as many times as it takes for the
            // list to fill up its available space, which is most likely more than the
            // number of todo items we have. So, we need to check the index is OK.
            if(index < members.length) {
              return buildResultMember(
                members[index], 
                index,
                member
                );
            }
          }
        );
  }
     var mostNumGuesses = 0;
     var listOfMostGuessed = new Map();

     Widget buildResultMember(Member member, int index, Member originalMember) {
       var numGuessForMember = originalMember.present.getGuessesForMember(member);
       var nonNullGuessNum = 0;
       if (numGuessForMember != null) {
         nonNullGuessNum = numGuessForMember;
       }
    return new ListTile(
      title: new Text(
        member.name + ": " + nonNullGuessNum.toString(),

        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 30,
            fontFamily: "Avenir",
            color: Colors.white
          ),
        ),
    );
  }

   Widget buildMember(Member member, int index) {
    return new ListTile(
      title: new Text(
        member.name,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 30,
            fontFamily: "Avenir",
            color: Colors.white
          ),
        ),
      onLongPress: () => promptRemoveMember(index),
    );
  }

void pushStartToScreen(String member) {
  // Push this page onto the stack
  List<String> listOfNames = [];
  
  for (Member member in members) {
    listOfNames.add(member.name);
  }


  Navigator.of(context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
    new MaterialPageRoute (
      builder: (context) {
        return new Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            backgroundColor: redColor,
            automaticallyImplyLeading: false,
            title: new Text('Gissa presenten', style: TextStyle(
              fontSize: 15
            ), textAlign: TextAlign.center),
            centerTitle: true,
          ),
          body: new Container(
            child: new Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text('Vem tror du att ' + member + '´s present\när till egentligen?', style: textStyleRedLarge, textAlign: TextAlign.center,),
                  new DropdownButton<String>(
                  items: listOfNames.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value, style: 
                    TextStyle(
                      fontSize: 20,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.bold,
                      color: greenColor,
                    )),
                  );
                }).toList(),
                hint: Text("Välj den du tror", style: 
                TextStyle(
                  fontSize: 20,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.bold,
                  color: redColor,
                  )
                ),
                onChanged: (selectedMember) {
                  print(selectedMember);
                  Member memberToUse;
                  Member memberGuessed;
                  for (Member memberT in members) {
                    if (memberT.name == member) {
                      memberToUse = memberT;
                  }
                  if (memberT.name == selectedMember) {
                    memberGuessed = memberT;
                  }
                }
                memberToUse.present.makeGuess(memberGuessed);
                Navigator.pop(context); // Close the add todo screen
              },
            ),
          ],
          )
          )
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

void pushResultToScreen(Member member) {
  // Push this page onto the stack
  Navigator.of(context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
    new MaterialPageRoute (
      builder: (context) {
        return new Scaffold(
        backgroundColor: greenColor,
        appBar: new AppBar(
          title: new Text('Presenten som ' + member.name + ' fick:'),
          centerTitle: true,
          backgroundColor: greenColor,
          automaticallyImplyLeading: false,
          textTheme: TextTheme(title: TextStyle(
            fontSize: 20,
            fontFamily: "Avenir",
            fontWeight: FontWeight.bold,
            color: Colors.white
          )),
          
        ),
        body: 
          buildResultMemberList(member),    
          floatingActionButton: new FloatingActionButton(
          tooltip: 'Add member',
          onPressed: () {
            if (listOfMostGuessed[member] != null) {
              print("The person most guessed was: " + listOfMostGuessed[member]);
              promptWhoShouldGetThePresent(listOfMostGuessed[member], context, member);
              // Navigator.pop(context);
            } else {
               Navigator.pop(context);
            }
          },
             
        
        child: new Icon(Icons.arrow_forward),
        foregroundColor: greenColor,
        backgroundColor: Colors.white,
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
            fontSize: 30,
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

// Show an alert dialog telling the user who was most voted for
void promptWhoShouldGetThePresent(String name, BuildContext newContext, Member member) {
  int numGuesses;
  for (Member memberT in members) {
    if (memberT.name == listOfMostGuessed[member]) {
      numGuesses = member.present.getGuessesForMember(memberT);
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Personen som borde få presenten är: ' + name  + '\nMed totalt: ' + numGuesses.toString() + ' antal röster.', style: TextStyle(
              fontSize: 20,
              fontFamily: "Avenir",
              fontWeight: FontWeight.bold,
              color: greenColor
              ),
            ),
          actions: <Widget>[
            new FlatButton(
            child: new Text('Nästa', style: TextStyle(
              fontSize: 20,
              fontFamily: "Avenir",
              fontWeight: FontWeight.bold,
              color: greenColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(newContext);
            }
          ),
          ],
      );
    }
  );
}

// Show an alert dialog asking the user to confirm that the task is done
void promptRemoveMember(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Vill du ta bort ${members[index].name} från listan?', style: TextStyle(
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