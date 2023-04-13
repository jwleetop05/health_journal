import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/models/argumentData.dart';
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
  final TextEditingController _sleepTimeHController = TextEditingController();
  final TextEditingController _sleepTimeMController = TextEditingController();
  final TextEditingController _kgController = TextEditingController();
  final TextEditingController _mController = TextEditingController();

  @override
  void dispose() {
    _dailyController.dispose();
    _sleepTimeHController.dispose();
    _sleepTimeMController.dispose();
    super.dispose();
  }

  Widget dailyWrite() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: size.width,
          child: const Text(
            "오늘 일기",
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "총 수면 시간 : ",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              width: size.width * 0.2,
              child: TextFormField(
                controller: _sleepTimeHController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  if (int.parse(value) > 24) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("정확한 시간을 입력해주세요"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              width: size.width * 0.1,
              child: const Text("시간"),
            ),
            SizedBox(
              width: size.width * 0.2,
              child: TextFormField(
                controller: _sleepTimeMController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  if (int.parse(value) > 60) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("정확한 시간을 입력해주세요"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              width: size.width * 0.1,
              child: const Text("분"),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: _dailyController,
            minLines: 10,
            maxLines: 10,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
          ),
        ),
      ],
    );
  }

  Widget dailyTodo() {
    InsertViewModel viewModel = Provider.of<InsertViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: PageView(
        children: Day.values.map((e) {
          final mealController = TextEditingController();
          final exerciseController = TextEditingController();
          return Column(
            children: [
              SizedBox(
                width: size.width,
                child: Text(
                  e.name,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: size.width * 0.85,
                child: Text(
                  "${e.name}운동",
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: size.width * 0.85,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: mealController,
                  minLines: 3,
                  maxLines: 8,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: size.width * 0.85,
                child: Text(
                  "${e.name} 섭취음식",
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: size.width * 0.85,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: exerciseController,
                  minLines: 3,
                  maxLines: 8,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () => viewModel.setDiary(
                  e.index,
                  mealController.value.text,
                  exerciseController.value.text,
                ),
                child: const Text("저장하기"),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget dailyOther() {
    Size size = MediaQuery.of(context).size;
    InsertViewModel viewModel = Provider.of<InsertViewModel>(context);
    final args = ModalRoute.of(context)!.settings.arguments as UserDateArgs;
    final date = DateTime(args.date.year, args.date.month, args.date.day);
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("스트레스"),
          const SizedBox(height: 15),
          SizedBox(
            width: size.width,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: Stress.values.asMap().entries.map(
                  (e) {
                    return InkWell(
                      onTap: () {
                        viewModel.stress = e.value;
                        viewModel.selected = e.key;
                      },
                      child: Container(
                        color: viewModel.selector.elementAt(e.key)
                            ? Colors.red
                            : Colors.white,
                        width: size.width * 0.2,
                        height: size.height * 0.07,
                        child: Text(
                          e.value.url,
                          textAlign: TextAlign.center,
                          style: const TextStyle(height: 2.9),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Text("몸무게"),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: size.width * 0.1,
                        child: TextFormField(
                          controller: _kgController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) {
                            if (value.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("몸무게를 적어주세요."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              return;
                            }
                            if (num.parse(value) > 280) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("몸무게를 적어주세요."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              return;
                            }
                            if (_mController.value.text.isNotEmpty) {
                              num raw = double.parse(_mController.value.text);
                              num res = num.parse(value) / pow(raw / 100, 2);
                              viewModel.bmi = res;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text("키"),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: size.width * 0.1,
                        child: TextFormField(
                          controller: _mController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) {
                            if (value.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("키를 적어주세요."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              return;
                            }
                            if (num.parse(value) > 220) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("키를 적어주세요."),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                            if (_kgController.value.text.isNotEmpty) {
                              num m = pow(double.parse(value) / 100, 2);
                              num res = num.parse(_kgController.value.text) / m;
                              viewModel.bmi = res;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("비만도 : "),
              () {
                if (viewModel.bmi < 0 ||
                    _kgController.value.text.isEmpty ||
                    _mController.value.text.isEmpty) {
                  return const Text("입력없음");
                }

                final bmis = {
                  35: "초고도비만",
                  30: "고도비만",
                  25: "비만",
                  23: "과체중",
                  18.5: "정상",
                  0: "저체중",
                };

                final a = bmis.keys.toList();
                assert(listEquals(a, ([...a]..sort()).reversed.toList()));

                for (var e in bmis.entries) {
                  if (viewModel.bmi >= e.key) {
                    return Text(
                      "${e.value} "
                      "(${NumberFormat('###.##').format(viewModel.bmi)})",
                    );
                  }
                }

                return const Text("입력없음");
              }(),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firebase.queryDiaryfromDate(
              isGtEq: Timestamp.fromDate(date),
              isLt: Timestamp.fromDate(date.add(const Duration(days: 1))),
            ).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return TextButton(
                  onPressed: () {
                    Diary diaryData = Diary(
                      id: args.email,
                      name: args.name,
                      date: args.date,
                      text: _dailyController.value.text,
                      sleep: Duration(
                        hours: int.parse(_sleepTimeHController.value.text),
                        minutes: int.parse(_sleepTimeMController.value.text),
                      ),
                      bmi: viewModel.bmi,
                      stress: viewModel.stress,
                      diary: viewModel.diary,
                    );
                    Firebase.diaries.add(diaryData.toJson());
                  },
                  child: const Text("최종 저장"),
                );
              }
              return TextButton(
                onPressed: () async {
                  Diary diaryData = Diary(
                    id: args.email,
                    name: args.name,
                    date: args.date,
                    text: _dailyController.value.text,
                    sleep: Duration(
                      hours: int.parse(_sleepTimeHController.value.text),
                      minutes: int.parse(_sleepTimeMController.value.text),
                    ),
                    bmi: viewModel.bmi,
                    stress: viewModel.stress,
                    diary: viewModel.diary,
                  );

                  final diary = await Firebase.queryDiaryfromDate(
                    isGtEq: Timestamp.fromDate(date),
                    isLt: Timestamp.fromDate(
                      date.add(const Duration(days: 1)),
                    ),
                  ).get();

                  Firebase.diaries
                      .doc(diary.docs.first.id)
                      .set(diaryData.toJson());
                },
                child: const Text("수정"),
              );
            },
          ),
        ],
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
                    switch (viewModel.tab) {
                      case DiaryTab.write:
                        return dailyWrite();
                      case DiaryTab.todo:
                        return dailyTodo();
                      case DiaryTab.other:
                        return dailyOther();
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
