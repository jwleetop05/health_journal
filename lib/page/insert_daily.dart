import 'package:flutter/material.dart';
import 'package:school_nurse_ofiice/util/firebase.dart';

class Insert_Daily extends StatefulWidget {
  const Insert_Daily({Key? key}) : super(key: key);

  @override
  State<Insert_Daily> createState() => _Insert_DailyState();
}

enum Stress { none, low, medium, high }

class _Insert_DailyState extends State<Insert_Daily> {
  Stress stress = Stress.none;
  List<String> str = ['일기', '오늘 한 일', '기타'];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top:0, child: Container(
              width: size.width,
              height: size.height * 0.4,
              color: Colors.cyanAccent,
              child: Stack(
                children: [
                  Positioned(bottom: 25,
                      child: Container(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: str.map((e) {
                            return TextButton(onPressed: (){}, child: Text(e),style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(20.0),
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 14, color: Colors.black),
                            ),);
                          }).toList(),
                        ),
                      )
                  )
                ],
              ),
            ),),
            Positioned(bottom: 0,child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: size.width,
              height: size.height * 0.6,
            ))
          ],
        ),
      ),
    );
  }
}
