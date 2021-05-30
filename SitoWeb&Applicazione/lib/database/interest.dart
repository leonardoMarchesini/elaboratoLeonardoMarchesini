import 'dart:convert';
import 'package:http/http.dart' as http;

class Interest {
  int? refId;
  String? classicDance;
  String? comedy;
  String? sport;
  String? neomelodica;
  String? pop;
  String? rock;

  Interest.fromJson(Map<String, dynamic> json) {
    this.refId = json['refId'];
    this.classicDance = json['classicDance'];
    this.comedy = json['comedy'];
    this.sport = json['sport'];
    this.neomelodica = json['neomelodica'];
    this.pop = json['pop'];
    this.rock = json['rock'];
  }
}
