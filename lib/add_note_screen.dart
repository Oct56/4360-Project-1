import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mood_journal/calendar.dart';
import 'package:mood_journal/note.dart';
import 'package:mood_journal/notes_database.dart';
import 'package:mood_journal/pick_images';


class AddNoteScreen extends StatefulWidget {
  final Note? note;
  const AddNoteScreen({super.key, this.note});
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}
PickImage image = PickImage();  
class _AddNoteScreenState extends State<AddNoteScreen> {
final _title = TextEditingController();
final _deescription = TextEditingController();
final _mood = TextEditingController();

@override
void initState(){
  if(widget.note != null){
    _title.text = widget.note!.title;
    _deescription.text = widget.note!.description;
  }
}


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
          IconButton(onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PickImage()),
                  );
          }, icon: const Icon(Icons.photo)),
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
        ],
      ),)
    );
  }
  _insertNote() async{
    final note = Note(
      title: _title.text,
      description: _deescription.text,
      mood: _mood.text
      //createdAt: DateTime.now()
    );
    await NotesDatabase.insert(note: note);
  }

  _updateNote() async{
    final note = Note(
      id: widget.note!.id!,
      title: _title.text,
      description: _deescription.text,
      mood: _mood.text
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

