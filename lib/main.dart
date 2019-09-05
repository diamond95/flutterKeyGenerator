import 'package:flutter/material.dart';
import 'dart:math';
import 'Animation.dart';
import 'package:http/http.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Web key generator',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Flutter Web Key Generator'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _key = 0;

  void _generateNewKey() {
    
    var rng = new Random();
    _key = rng.nextInt(900000) + 100000;
    
    setState(() => _key);
   
  }

    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            
            title: new Text("About"),
            content: new Text("This is a simple flutter application that generates 6-digit code and updates it to a web server. \n\nAfter the update, the administrator types this code in the web application on login site.        \n\n\nCreator: Ivan Miljanić "),
            
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
     void _showDialogError() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            
            title: new Text("Error"),
            content: new Text("Key can't be 0. You must generate new key."),

            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    void _showDialogOk() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Success"),
            content: new Text("Key updated!\n\nYou can login now."),
            
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    _makePostRequest() async {
     

      // set up POST request arguments
      String url = 'https://developer-hr.com/newkey.php'; // you can use this url for testing purposes
      Map<String, String> headers = {"Content-type": "application/json"};
      String text = '{"key": "$_key"}';

      // make POST request
      Response response = await post(url, headers: headers, body: text);
      // check the status code for the result
      int statusCode = response.statusCode;
      String body = response.body;
      //print(body);
      if(body == "error") {
        _showDialogError();
      } else {
        _showDialogOk();
      }
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar( 
        title: Text(widget.title), 
        actions: <Widget>[ 
          new IconButton( icon: new Icon(Icons.info_outline), tooltip: 'Info', onPressed: _showDialog, ),],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ShowUp(child: Text(
              'Please use button refresh to generate new key',
              style: TextStyle(color: Colors.black.withOpacity(1.0), fontWeight: FontWeight.bold),
            ),
              delay: 600,
            ),
            ShowUp(child: Text(
              '$_key',
              style: Theme.of(context).textTheme.display1,
            ),
              delay: 1000,
            ),

            
          ],
        ),
      ),
      floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: _makePostRequest,
                  child: Icon(Icons.check),
                  tooltip: 'Update new key',
                ),
                FloatingActionButton(
                  onPressed: _generateNewKey,
                  child: Icon(Icons.autorenew),
                  tooltip: 'Generate new key',
                )
              ],
            ),
          )
    );
  }
}