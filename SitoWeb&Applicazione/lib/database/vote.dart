import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Vote {
  String? refPostId;
  String? refUserId;
  int? vote;

  Vote.fromJson(Map<String, dynamic> json) {
    this.refPostId = json['refPostId'];
    this.refUserId = json['refUserId'];
    this.vote = json['vote'];
  }
}
