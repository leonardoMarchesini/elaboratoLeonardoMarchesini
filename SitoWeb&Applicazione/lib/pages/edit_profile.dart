import "package:flutter/material.dart";
import 'package:testosocial2/database/account.dart';
import 'package:testosocial2/database/method.dart';
import 'package:testosocial2/models/user.dart';
import 'package:testosocial2/pages/home.dart';
import 'package:testosocial2/widget/progress.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController capController = TextEditingController();
  String getNewsLetter = "1";
  bool isLoading = false;
  bool isSwitched = true;
  late User user;
  bool _displayNameValid = true;
  bool _bioValid = true;
  int classicDance = 0;
  int comedy = 0;
  int sport = 0;
  int neomelodica = 0;
  int pop = 0;
  int rock = 0;
  int countInterest = 0;

  @override
  void initState() {
    super.initState();
    //getUser();
  }

  /*getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await usersRef.doc(currentUser.id).get();
    user = User.fromDocument(doc);
    displayNameController.text = user.displayName;
    bioController.text = user.bio;

    setState(() {
      isLoading = false;
    });
  }*/

  buildDisplayNameField() {
    return FutureBuilder(
      future: getUser(currentUser.email),
      builder: (context, AsyncSnapshot<Account> snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 12.0,
              ),
            ),
            TextField(
              controller: displayNameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: "Full Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: snapshot.data!.displayName,
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  buildUsernameField() {
    return FutureBuilder(
      future: getUser(currentUser.email),
      builder: (context, AsyncSnapshot<Account> snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 12.0,
              ),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: "Username",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: snapshot.data!.username,
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  buildBioField() {
    return FutureBuilder(
      future: getUser(currentUser.email),
      builder: (context, AsyncSnapshot<Account> snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 12.0,
              ),
            ),
            TextField(
              controller: bioController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: "Bio",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: snapshot.data!.bio,
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  buildCapField() {
    return FutureBuilder(
      future: getUser(currentUser.email),
      builder: (context, AsyncSnapshot<Account> snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 12.0,
              ),
            ),
            TextField(
              controller: capController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: "Cap",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: snapshot.data!.cap, //currentUser.cap,
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  buildNewsLetterSwitch() {
    return Row(
      children: <Widget>[
        Text(
          "Recepit of Newsletter:",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
        Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              if (isSwitched) {
                changeInfo(
                    currentUser.id,
                    currentUser.email,
                    currentUser.username,
                    currentUser.photoUrl,
                    currentUser.bio,
                    currentUser.displayName,
                    currentUser.cap,
                    "0");
                getNewsLetter = "0";
              } else {
                changeInfo(
                    currentUser.id,
                    currentUser.email,
                    currentUser.username,
                    currentUser.photoUrl,
                    currentUser.bio,
                    currentUser.displayName,
                    currentUser.cap,
                    "1");
                getNewsLetter = "1";
              }
            });
          },
          activeTrackColor: Colors.purple[300],
          activeColor: Colors.deepPurple,
        ),
      ],
    );
  }

  updateProfileData() {
    setState(() {
      displayNameController.text.trim().length < 3 ||
              displayNameController.text.isEmpty
          ? _displayNameValid = false
          : _displayNameValid = true;
      bioController.text.trim().length > 100
          ? _bioValid = false
          : _bioValid = true;
    });

    if (_displayNameValid && _bioValid) {
      changeInfo(
          currentUser.id,
          currentUser.email,
          usernameController.text,
          currentUser.photoUrl,
          bioController.text,
          displayNameController.text,
          capController.text,
          getNewsLetter);

      SnackBar snackbar = SnackBar(content: Text("Profile updated!"));
      _scaffoldKey.currentState!.showSnackBar(snackbar);
    }
  }

  logout() async {
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.deepPurple,
          ),
          onPressed: () => Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.deepPurple,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? circularProgress()
          : ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 25,
                    right: 16,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 4,
                                    color: Colors.white,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(currentUser.photoUrl),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Colors.white,
                                    ),
                                    color: Colors.deepPurple,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Column(
                          children: <Widget>[
                            buildDisplayNameField(),
                            buildUsernameField(),
                            buildBioField(),
                            buildCapField(),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlineButton(
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onPressed: logout,
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: updateProfileData,
                              color: Colors.deepPurple,
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
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
