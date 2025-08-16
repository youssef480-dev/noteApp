import 'package:flutter/material.dart';
import 'package:note_application/screen/screen.dart';
import 'package:note_application/helpers/hive_helpers.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async { 
   WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveHelpers.notesBox);
  await HiveHelpers.getNotes();
    runApp(MyApp());


}

class MyApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}