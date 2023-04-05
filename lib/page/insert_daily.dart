import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/models/diary.dart';
import 'package:school_nurse_ofiice/page/insert_view_model.dart';
import 'package:school_nurse_ofiice/util/firebase.dart';

class InsertDaily extends StatefulWidget {
  const InsertDaily({Key? key}) : super(key: key);

  @override
  State<InsertDaily> createState() => _InsertDailyState();
}

class _InsertDailyState extends State<InsertDaily> {
  final TextEditingController _dailyController = TextEditingController();
  Widget dailyWrite() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: size.width,
          child: const Text("오늘 일기", textAlign: TextAlign.start,),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: _dailyController,
            minLines: 8,
            maxLines: 8,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
          ),
        )
      ],
    );
  }
  Widget dailyTodo() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: PageView(
          children: Day.values.map((e) {
            final TextEditingController _mealController = TextEditingController();
            final TextEditingController _exerciseController = TextEditingController();
            return  Column(
              children: [
                SizedBox(
                  width: size.width,
                  child: Text(e.name, style: const TextStyle(fontSize: 24), textAlign: TextAlign.start,),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: size.width,
                  child: Text("${e.name}운동", textAlign: TextAlign.start,),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: _mealController,
                    minLines: 3,
                    maxLines: 8,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: size.width,
                  child: Text("${e.name} 섭취음식", textAlign: TextAlign.start,),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: _exerciseController,
                    minLines: 3,
                    maxLines: 8,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(onPressed: (){}, child: const Text("저장하기")),
              ],
            );
          }).toList()
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    InsertViewModel viewModel = Provider.of<InsertViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.4,
                color: Colors.cyanAccent,
                child: Stack(
                  children: [
                    Positioned(
                      width: size.width,
                      height: 56,
                      top: size.height * 0.4 - 81,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: DiaryTab.values.map((e) {
                          return TextButton(
                            onPressed: () {
                              viewModel.tab = e;
                            },
                            style: TextButton.styleFrom(
                              maximumSize: Size(size.width, 54),
                              padding: const EdgeInsets.all(20.0),
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            child: Text(e.name),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: size.width,
                height: size.height * 0.6,
                child: SingleChildScrollView(
                  child: () {
                    switch(viewModel.tab) {
                      case DiaryTab.write: return dailyWrite();
                      case DiaryTab.todo: return dailyTodo();
                      case DiaryTab.other: return Container();
                    }
                  }(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
