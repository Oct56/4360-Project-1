import 'package:flutter/foundation.dart';

class Note{
  int? id;
  late String title, description, mood;
  late DateTime createdAt;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.mood
    //required this.createdAt
  });

  Map<String, dynamic> toMap(){
    return{
      'title':title,
      'description':description,
      'mood': mood
      ///'createdAt': createdAt.toString()
    };
  }
}