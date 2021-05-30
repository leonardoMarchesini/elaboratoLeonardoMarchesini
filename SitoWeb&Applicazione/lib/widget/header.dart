import 'package:flutter/material.dart';

AppBar header(context,
    {bool isAppTitle = false,
    String titleText = "",
    removeBackButton = false}) {
  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    toolbarHeight: 80,
    automaticallyImplyLeading: removeBackButton,
    title: Text(
      isAppTitle ? "SmartSocial" : titleText,
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Signatra",
        fontSize: isAppTitle ? 50.0 : 40.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.deepPurple,
    elevation: 0.0,
  );
}
