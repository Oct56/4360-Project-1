import 'package:flutter/material.dart';
import 'package:mood_journal/add_note_screen.dart';
import 'package:mood_journal/item_note.dart';
import 'package:mood_journal/note.dart';
import 'package:mood_journal/notes_database.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    //this allows user to select dates on tap
    setState(() {
      today = day;
    });
  }

  Future<List<Note>> _fetchNotes() async {
    return await NotesDatabase.getNotes();
  }

  final noteDB = NotesDatabase();
  Future<void> _queryAll() async {
    final allRows = await noteDB.queryAllRows();
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => setState(() {}), icon: const Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                child: TableCalendar(
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    availableGestures: AvailableGestures.all,
                    focusedDay: today,
                    onDaySelected: _onDaySelected,
                    selectedDayPredicate: (day) =>
                        isSameDay(day, today), //allows the selection

                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(color: Colors.black54),
                    weekendTextStyle: TextStyle(color: Colors.red),
                    todayDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 30, 78, 231),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue, // Change color of selected date
                      shape: BoxShape.circle,
                    ),
                  ),
                    ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddNoteScreen()),
                  );
                }, //submission button, replace null with
                child: Text('New Note'),
              ),
              Row(
                children: [
              ElevatedButton(
                onPressed: () async {
                  await noteDB;
                  await _queryAll();
                },
                //submission button, replace null with
                child: Text('Query'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await NotesDatabase.deleteAllNotes();
                  setState(() {});
                },
                child: Text('Delete All Notes'),
              )]
              ),
              Expanded(
                  child: FutureBuilder<List<Note>>(
                      future: NotesDatabase.getNotes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          //debugPrint(NotesDatabase.getNotes() as String?);
                          //debugPrint(snapshot.data as String?);
                          //debugPrint(snapshot.error as String?);
                          if (snapshot.data == null || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("empty"),
                            );
                          }
                          return ListView(
                            padding: const EdgeInsets.all(15),
                            children: [
                              for (var note in snapshot.data!)
                                ItemNote(
                                  note: note,
                                )
                            ],
                          );
                        }
                        //debugPrint('i tried $list');
                        return SizedBox();
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
