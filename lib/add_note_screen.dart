import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mood_journal/calendar.dart';
import 'package:mood_journal/note.dart';
import 'package:mood_journal/notes_database.dart';
import 'package:mood_journal/pick_images';
import 'package:image_picker/image_picker.dart'; // added by Ahmad
import 'dart:io'; // added by Ahmad


class AddNoteScreen extends StatefulWidget {
  final Note? note;
  const AddNoteScreen({super.key, this.note});
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}
PickImage image = PickImage(); 

class _AddNoteScreenState extends State<AddNoteScreen> {
 File? _image; // added by Ahmad
final _title = TextEditingController();
final _deescription = TextEditingController();
final _mood = TextEditingController();

@override
void initState(){
  super.initState(); // added by Ahmad
  if(widget.note != null){
    _title.text = widget.note!.title;
    _deescription.text = widget.note!.description;
    _image = widget.note!.imagePath != null ? File(widget.note!.imagePath!) : null; // added by Ahmad
  }
}

Future<void> _pickImage() async { //start, added by Ahmad
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  } // end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          widget.note != null? IconButton(onPressed: () {
            showDialog(context: context, builder: (context) => AlertDialog(
              content: const Text('Are you sure you want to delete?'),
              actions: [
                TextButton(onPressed: () {
                  Navigator.pop(context);
                  _deleteNote();
                }, child: const Text('Yes')),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: const Text('No')),
              ],
            ));
          }, icon: const Icon(Icons.delete)): const SizedBox(),
          IconButton(onPressed: _pickImage, icon: const Icon(Icons.photo)), // modified by Ahmad
        
          IconButton(onPressed: () {
            widget.note == null? _insertNote(): _updateNote();
          }, icon: const Icon(Icons.done)),
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: _title,
            decoration:  InputDecoration(hintText: 'Title',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(height: 15,),
          TextField(
            controller: _mood,
            decoration:  InputDecoration(hintText: 'Mood',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(height: 15,),
          Expanded(
            child:
          TextField(
            controller: _deescription,
            decoration:  InputDecoration(hintText: 'Start typing here',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
            maxLines: 30,
          )
          ),
          if (_image != null) 
          Container(
                height: 200,
                width: 200,
                child: Image.file(_image!), // added by Ahmad
              ),
        ],
      ),)
    );
  }
  _insertNote() async{
    final note = Note(
      title: _title.text,
      description: _deescription.text,
      mood: _mood.text ,
      imagePath: _image?.path, // added by Ahmad
      //createdAt: DateTime.now()
    );
    await NotesDatabase.insert(note: note);
  }

  _updateNote() async{
    final note = Note(
      id: widget.note!.id!,
      title: _title.text,
      description: _deescription.text,
      mood: _mood.text,
      imagePath: _image?.path, // added by Ahmad
      ///createdAt: widget.note!.createdAt
    );
    await NotesDatabase.update(note: note);
  }

  _deleteNote() async{
    NotesDatabase.delete(note: widget.note!).then((e) {
      Navigator.pop(context);
    });
  }
}

