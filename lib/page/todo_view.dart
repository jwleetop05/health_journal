import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/models/argument_data.dart';
import 'package:school_nurse_ofiice/models/diary.dart';
import 'package:school_nurse_ofiice/models/json.dart';
import 'package:school_nurse_ofiice/page/todo_view_model.dart';
import 'package:school_nurse_ofiice/util/auth.dart';
import 'package:school_nurse_ofiice/util/firebase.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key, required this.userData}) : super(key: key);

  static const routeName = '/todo';
  final LoginArgs userData;
  @override
  State<Todo> createState() => _TodoState();
}
// tabbar로 달력으로 도장만 보는거
//달력으로 great, good 등 도장만 보여주기
//ListView를 통해 간략한 내용
// tabber initalIndex로 제일 처음에 여태 글쓰거 요약본? 약간
// 이거의 제일 윗부분은 글 쓰러가기 등등..
// 밑에거는 저장하는된거 보여줌
//(몸무게, 그날의 기분 등) 이부분 보여주고
//+ great, good 도장 + 날짜

// tabbar 사용하는게 좋을것같음
class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TodoViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Auth.signOut();
                },
                child: const Text("로그아웃"),
              ),
              buildList(),
              if (viewModel.day == DateTime.now().day)
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('수정'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    final now = DateTime.now();
    final week = List.generate(7, (i) => now.subtract(Duration(days: i)));
    return ListView.builder(
      shrinkWrap: true,
      itemCount: week.length,
      itemBuilder: (context, i) => SizedBox(
        height: 120,
        child: buildEditor(week[i], now),
      ),
    );
  }

  Widget buildEditor(DateTime dt, DateTime now) {
    final viewModel = Provider.of<TodoViewModel>(context);
    final date = DateTime(dt.year, dt.month, dt.day);
    return StreamBuilder<QuerySnapshot>(
      stream: Firebase.queryDiaryfromDate(
        id: widget.userData.user.email,
        isGtEq: Timestamp.fromDate(date),
        isLt: Timestamp.fromDate(date.add(const Duration(days: 1))),
      ).snapshots(),
      builder: (context, snapshot) {
        return ListTile(
          onTap: () {
            viewModel.day = dt.day;
            if (snapshot.hasError) {
              return print(snapshot.error);
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              Navigator.pushNamed(
                context,
                '/insert',
                arguments: InsertDataArgs(
                  date: dt,
                  name: widget.userData.user.name,
                  email: widget.userData.user.email,
                ),
              );
              return print("route");
            }
            final doc = Diary.fromJson(snapshot.data!.docs[0].data() as JSON);
            Navigator.pushNamed(
              context,
              '/insert',
              arguments: InsertDataArgs(
                date: dt,
                name: widget.userData.user.name,
                email: widget.userData.user.email,
                diary: doc,
              ),
            );
          },
          tileColor: now.day == dt.day ? Colors.amber : Colors.white,
          leading: Text(DateFormat('MM/dd').format(dt)),
          title: () {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('Empty');
            }
            final doc = Diary.fromJson(snapshot.data!.docs[0].data() as JSON);
            final date = DateFormat('yyyy-MM-dd HH:mm').format(doc.date);
            return Text(date);
          }(),
        );
      },
    );
  }
}
