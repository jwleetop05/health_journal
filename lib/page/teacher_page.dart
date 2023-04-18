import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_nurse_ofiice/util/firebase.dart';
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
    final now = DateTime.now();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: StreamBuilder<Object>(
                stream: Firebase.queryDiaryfromDate(
                  isGtEq: Timestamp.fromDate(DateTime(now.year, now.month)),
                  isLt: Timestamp.fromDate(DateTime(now.year, now.month + 1)),
                ).snapshots(),
                builder: (context, snapshot) {
                  return TableCalendar(
                    firstDay: DateTime.utc(2023, 1, 16),
                    lastDay: DateTime(now.year + 10),
                    focusedDay: now,
                  );
                }),
          ),
        ),
      ),
    );
  }
}
