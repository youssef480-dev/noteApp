import 'package:hive/hive.dart';

class HiveHelpers {
  static const String notesBox = 'notesBox';
  static const String notesKey = "notesKey";
  static List<String> myNotes = [];

  static var box = Hive.box(notesBox);

  static void addNote(String noteText)async {
    myNotes.add(noteText);
  await box.put(notesKey, myNotes);
    
  }

    static Future<void> getNotes()async {
    myNotes =box.get(notesKey);

    
  }
   static void removeNote(int index) async {
    myNotes.removeAt(index);
    await box.put(notesKey, myNotes);
  }

  static void removeAllNote() async {
    myNotes = [];
    await box.put(notesKey, myNotes);
  }

  static void updateNote(String noteText, int index) async {
    myNotes[index] = noteText;
    await box.put(notesKey, myNotes);
  }
}