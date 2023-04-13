import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/models/argumentData.dart';
import 'package:school_nurse_ofiice/page/todo_view_model.dart';
import 'package:school_nurse_ofiice/util/auth.dart';
import 'package:school_nurse_ofiice/util/firebase.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

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
                  child: const Text("로그아웃")),
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
    final viewModel = Provider.of<TodoViewModel>(context);
    final args = ModalRoute.of(context)!.settings.arguments as LoginArguments;
    final now = DateTime.now();
    final week = List.generate(7, (i) => now.subtract(Duration(days: i)));
    return ListView.builder(
      shrinkWrap: true,
      itemCount: week.length,
      itemBuilder: (context, i) => SizedBox(
        height: 90,
        child: ListTile(
          onTap: () {
            viewModel.day = week[i].day;
            Navigator.pushNamed(context, '/insert',
                arguments: UserDateArguments(
                    week[i], args.user.name, args.user.email));
          },
          tileColor: now.day == week[i].day ? Colors.amber : Colors.white,
          leading: Text(DateFormat('MM/dd').format(week[i])),
          title: buildEditor(week[i]),
        ),
      ),
    );
  }

  Widget buildEditor(DateTime dt) {
    final date = DateTime(dt.year, dt.month, dt.day);
    return StreamBuilder<QuerySnapshot>(
      stream: Firebase.getDiaryfromDate(
        isGtEq: Timestamp.fromDate(date),
        isLt: Timestamp.fromDate(date.add(const Duration(days: 1))),
      ).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('Empty');
        }
        final data = DateFormat('yyyy-MM-dd-hh-mm')
            .format(snapshot.data?.docs[0]['date'].toDate());
        return Text('$data');
      },
    );
  }
}
