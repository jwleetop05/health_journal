import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  static const routeName = '/teacher';

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: TableCalendar,
          ),
        ),
      ),
    );
  }
}
