import 'package:flutter/material.dart';
import 'package:mood_journal/add_note_screen.dart';
import 'package:mood_journal/calendar.dart';
import 'package:mood_journal/note.dart';

final calendar = Calendar();

class ItemNote extends StatelessWidget{
  final Note note;
  const ItemNote({super.key, required this.note});
  
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => AddNoteScreen(note: note,)));
      },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: 
        Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue
            ),
            child: 
            Column(
              children: [
                Text('hi',
                style: TextStyle(color: Colors.white),),
                
            ],
            ),
          ),
          const SizedBox(width: 15,),
          Expanded(
            child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.title,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,),
              Text(note.description,
              style: TextStyle(
                height: 1.5
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              ),
          ],))
      ],
      ),
    )
    );
  }
}