import 'package:flutter/material.dart';

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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView()
            ],
          ),
        ),
      )
    );
  }
}
