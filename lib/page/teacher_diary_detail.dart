import 'package:flutter/material.dart';

import '../models/argument_data.dart';

class TeacherDiaryDetail extends StatefulWidget {
  const TeacherDiaryDetail({Key? key, required this.diary}) : super(key: key);

  final DetailPageArgs? diary;
  static const routeName = "/TeacherDetail";
  @override
  State<TeacherDiaryDetail> createState() => _TeacherDiaryDetailState();
}

class _TeacherDiaryDetailState extends State<TeacherDiaryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(widget.diary?.diary?.id ?? ""),
              Text(widget.diary?.diary?.name ?? ""),
              Text(widget.diary?.diary?.stress.url ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
