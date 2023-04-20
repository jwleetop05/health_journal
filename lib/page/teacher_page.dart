import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/models/argument_data.dart';
import 'package:school_nurse_ofiice/models/diary.dart';
import 'package:school_nurse_ofiice/page/teacher_view_model.dart';
import 'package:school_nurse_ofiice/util/firebase.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/json.dart';
import '../util/auth.dart';
import '../util/firebase.dart';

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
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Auth.signOut();
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text("로그아웃"),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: Firebase.queryDiaryfromDate(
                    isGtEq: Timestamp.fromDate(
                        DateTime(viewModel.now.year, viewModel.now.month)),
                    isLt: Timestamp.fromDate(
                        DateTime(viewModel.now.year, viewModel.now.month + 1)),
                  ).snapshots(),
                  builder: (context, snapshot) {
                    late Diary? doc;
                    return TableCalendar(
                      locale: 'ko_KR',
                      firstDay: DateTime.utc(2023, 1, 16),
                      lastDay: DateTime(viewModel.now.year + 10),
                      focusedDay: viewModel.now,
                      calendarStyle: const CalendarStyle(
                          selectedDecoration: BoxDecoration(
                              color: Color(0xff5c6bc0),
                              shape: BoxShape.circle)),
                      onDaySelected: (selectedDay, focusedDay) {
                        viewModel.selectDay = selectedDay;
                        viewModel.focusDay = focusedDay;
                        doc = null;
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            if (snapshot.hasError) {
                              return Container(
                                height: 120,
                                child: ListTile(
                                  title: Text("error : ${snapshot.error}"),
                                ),
                              );
                            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Container(
                                height: 120,
                                child: const ListTile(
                                  title: Text("데이터가 비어있다"),
                                ),
                              );
                            } else {
                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                doc = Diary.fromJson(
                                    snapshot.data!.docs[i].data() as JSON);
                                if (DateFormat("yyyy-MM-dd").format(doc!.date) ==
                                    DateFormat("yyyy-MM-dd")
                                        .format(viewModel.selectDay)) {
                                  break;
                                }
                              }
                              final len = snapshot.data!.docs.where((e) {
                                final checkDate =
                                    Diary.fromJson(e.data() as JSON);
                                return DateFormat("yyyy-MM-dd")
                                        .format(checkDate.date) ==
                                    DateFormat("yyyy-MM-dd")
                                        .format(viewModel.selectDay);
                              }).length;
                              return SizedBox(
                                height: size.height * 0.6,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: len == 0 ? 1 : len,
                                  itemBuilder: (context, index) {
                                    if (DateFormat("yyyy-MM-dd")
                                            .format(doc?.date ?? DateTime(1)) ==
                                        DateFormat("yyyy-MM-dd")
                                            .format(viewModel.selectDay)) {
                                      return Container(
                                          height: 120,
                                          child: ListTile(
                                            title: Text(doc?.name ?? ""),
                                            subtitle: Text(doc?.text ?? ""),
                                          ));
                                    } else {
                                      return Center(
                                          child: ListTile(
                                        title: Text(
                                            "${DateFormat("yyyy-MM-dd").format(viewModel.selectDay)} 날짜에 등록된 일지가 없습니다."),
                                      ));
                                    }
                                  },
                                ),
                              );
                            }
                          },
                        );
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(viewModel.selectDay, day);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
