import 'package:flutter/material.dart';

class Insert_Daily extends StatefulWidget {
  const Insert_Daily({Key? key}) : super(key: key);

  @override
  State<Insert_Daily> createState() => _Insert_DailyState();
}

enum Stress { none, low, medium, high }

class _Insert_DailyState extends State<Insert_Daily> {
  Stress stress = Stress.none;
  @override
  Widget build(BuildContext context){
    return Container();
  }
}
