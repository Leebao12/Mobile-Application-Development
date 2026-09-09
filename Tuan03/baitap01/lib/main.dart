import 'package:flutter/material.dart';

import 'screens/student_screen.dart';
import 'screens/teacher_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài tập 01',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StudentScreen(),
      routes: {
        '/student': (context) => const StudentScreen(),
        '/teacher': (context) => const TeacherScreen(),
      },
    );
  }
}
