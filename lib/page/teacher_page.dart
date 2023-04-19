import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/models/argument_data.dart';
import 'package:school_nurse_ofiice/page/teacher_view_model.dart';
import 'package:school_nurse_ofiice/util/firebase.dart';
import 'package:table_calendar/table_calendar.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key, required this.userData}) : super(key: key);

  final LoginArgs userData;
  static const routeName = '/teacher';

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TeacherViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: StreamBuilder<Object>(
                stream: Firebase.queryDiaryfromDate(
                  isGtEq: Timestamp.fromDate(
                      DateTime(viewModel.now.year, viewModel.now.month)),
                  isLt: Timestamp.fromDate(
                      DateTime(viewModel.now.year, viewModel.now.month + 1)),
                ).snapshots(),
                builder: (context, snapshot) {
                  return TableCalendar(
                    locale: 'ko_KR',
                    firstDay: DateTime.utc(2023, 1, 16),
                    lastDay: DateTime(viewModel.now.year + 10),
                    focusedDay: viewModel.now,
                    calendarStyle: const CalendarStyle(
                      selectedDecoration:  BoxDecoration(
                        color: Color(0xff5c6bc0),
                          shape: BoxShape.circle
                      )
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      viewModel.selectDay = selectedDay;
                      viewModel.focusDay = focusedDay;
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: size.height * 0.6,
                            child: SingleChildScrollView(
                              child: Text(DateFormat("yyyy-MM-dd").format(viewModel.selectDay)),
                            ),
                          );
                        },
                      );
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(viewModel.selectDay, day);
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }
}
