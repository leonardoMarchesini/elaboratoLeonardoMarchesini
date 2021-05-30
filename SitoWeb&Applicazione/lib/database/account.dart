import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Account {
  String? id;
  String? email;
  String? username;
  String? photoUrl;
  String? bio;
  String? displayName;
  int? countComment;
  int? countPost;
  String? cap;

  Account({
    @required this.id,
    @required this.email,
    @required this.username,
    @required this.photoUrl,
    @required this.bio,
    @required this.displayName,
    @required this.countComment,
    @required this.countPost,
    @required this.cap,
  });

  Account.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.email = json['email'];
    this.username = json['username'];
    this.photoUrl = json['photoUrl'];
    this.bio = json['bio'];
    this.displayName = json['displayName'];
    this.countComment = json['countComment'];
    this.countPost = json['countPost'];
    this.cap = json['cap'];
  }
}

class Accounts {
  List<Account>? accounts;

  Accounts() {
    this.accounts = [];
    _setAccount();
  }

  Future<List<Account>> fetchAccount() async {
    var response = await http.get(Uri.http('localhost:3000', '/account'));
    var responseAccount = json.decode(response.body) as List;
    if (response.statusCode == 200) {
      responseAccount
          .map((e) => Account.fromJson(e))
          .toList()
          .forEach((element) {
        print(element.email!);
      });
      return responseAccount.map((e) => Account.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  void _setAccount() async {
    accounts!.addAll(await fetchAccount());
  }
}
