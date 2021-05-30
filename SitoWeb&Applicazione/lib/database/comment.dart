import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentDB {
  int? commentId;
  String? codMittente;
  String? text;
  String? photoUrl;
  String? refPostId;

  CommentDB.fromJson(Map<String, dynamic> json) {
    this.commentId = json['commentId'];
    this.codMittente = json['codMittente'];
    this.text = json['text'];
    this.refPostId = json['refPostId'];
  }
}

class Comments {
  List<Comments>? comment;

  Comments() {
    this.comment = [];
  }
}
