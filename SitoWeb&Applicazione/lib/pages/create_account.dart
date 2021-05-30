import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testosocial2/database/method.dart';
import 'package:testosocial2/pages/home.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController capController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  int classicDance = 0;
  int comedy = 0;
  int sport = 0;
  int neomelodica = 0;
  int pop = 0;
  int rock = 0;
  int countInterest = 0;
  String? username;

  submit() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(
        content: Text("Welcome $username!"),
      );
      _scaffoldKey.currentState!.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
    makePostRequest(
      currentUser.id,
      currentUser.email,
      currentUser.username,
      currentUser.photoUrl,
      currentUser.bio,
      currentUser.displayName,
      "0",
      "0",
      capController.text,
    );
    makePostRequestInterest(
      6,
      classicDance,
      comedy,
      sport,
      neomelodica,
      pop,
      rock,
    );
  }

  validation() {}

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.deepPurple,
                  Colors.teal,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Center(
              child: Text(
                'SmartSocial',
                style: TextStyle(
                  fontFamily: "Signatra",
                  fontSize: 90.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKey,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        validator: (val) {
                          if (val!.trim().length < 3 || val.isEmpty) {
                            return "Username too short";
                          } else if (val.trim().length > 12) {
                            return "Username too long";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) => username = val,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Username",
                            contentPadding: EdgeInsets.only(left: 10),
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                            ),
                            hintText: "Must be at least 3 characters"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: capController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Cap",
                          contentPadding: EdgeInsets.only(left: 10),
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          ),
                          hintText: "Must be 5 characters"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 40.0,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 250.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary:
                            classicDance == 1 ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          classicDance = 1;
                        });
                        countInterest++;
                      },
                      child: Text(
                        "Classic Dance",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: comedy == 1 ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          comedy = 1;
                        });
                        countInterest++;
                      },
                      child: Text(
                        "Comedy",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: sport == 1 ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          sport = 1;
                        });
                        countInterest++;
                      },
                      child: Text(
                        "Sport",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary:
                            neomelodica == 1 ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          neomelodica = 1;
                        });
                        countInterest++;
                      },
                      child: Text(
                        "Neomelodica",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: pop == 1 ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          pop = 1;
                        });
                        countInterest++;
                      },
                      child: Text(
                        "Pop",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: rock == 1 ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          rock = 1;
                        });
                        countInterest++;
                      },
                      child: Text(
                        "Rock",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 200,
          ),
          Expanded(
            child: Center(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: submit,
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.deepPurple, Colors.teal],
                          end: Alignment.centerLeft,
                          begin: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Join the community",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
