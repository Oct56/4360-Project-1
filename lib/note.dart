import 'package:flutter/foundation.dart';

class Note{
  int? id;
  late String title, description, mood;
  late DateTime createdAt;
  String? imagePath; // added by Ahmad

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.mood,
    this.imagePath, // added by Ahmad
    //required this.createdAt
  });

  Map<String, dynamic> toMap(){
    return{
      'title':title,
      'description':description,
      'mood': mood,
      'imagePath': imagePath, // added by Ahmad
      ///'createdAt': createdAt.toString()
    };
  }

  static Note fromMap(Map<String, dynamic> map) {// added by Ahmad
    return Note(// added by Ahmad
      id: map['id'],// added by Ahmad
      title: map['title'],// added by Ahmad
      description: map['description'],// added by Ahmad
      mood: map['mood'],// added by Ahmad
      imagePath: map['imagePath'], // added by Ahmad
    );
  }
}