import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/models/diary.dart';
import 'package:school_nurse_ofiice/page/insert_view_model.dart';

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
    // TODO: implement dispose
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
        const SizedBox(
          height: 15,
        ),
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("정확한 시간을 입력해주세요"),
                        duration: Duration(seconds: 1)));
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("정확한 시간을 입력해주세요"),
                        duration: Duration(seconds: 1)));
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
        const SizedBox(
          height: 15,
        ),
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
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: PageView(
          children: Day.values.map((e) {
        final TextEditingController _mealController = TextEditingController();
        final TextEditingController _exerciseController =
            TextEditingController();
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
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: size.width * 0.85,
              child: Text(
                "${e.name}운동",
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: size.width * 0.85,
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
              width: size.width * 0.85,
              child: Text(
                "${e.name} 섭취음식",
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: size.width * 0.85,
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
            TextButton(onPressed: () {}, child: const Text("저장하기")),
          ],
        );
      }).toList()),
    );
  }

  Widget dailyOther() {
    Size size = MediaQuery.of(context).size;
    InsertViewModel viewModel = Provider.of<InsertViewModel>(context);
    print(viewModel.selector);
    return SizedBox(
      width: size.width,
      height: size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("스트레스"),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: size.width,
            child: Align(
              alignment: Alignment.center,
              child: ToggleButtons(
                isSelected: viewModel.selector,
                onPressed: (value) {
                  viewModel.selected = value;
                },
                borderRadius: BorderRadius.circular(10),
                borderWidth: 0,
                children: Stress.values.asMap().entries.map(
                  (e) {
                    return SizedBox(
                      width: size.width * 0.2,
                      height: size.height * 0.07,
                      child: Text(
                        e.value.url,
                        textAlign: TextAlign.center,
                        style: const TextStyle(height: 2.9),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: size.width,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      const Text("몸무게"),
                      TextFormField(
                        controller: _kgController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          if (value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("몸무게를 적어주세요."),
                                    duration: Duration(seconds: 1)));
                          } else {
                            if(num.parse(value) > 280) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("몸무게를 적어주세요."),
                                      duration: Duration(seconds: 1)));
                            } else if(value.isNotEmpty && _mController.value.text.isNotEmpty) {
                              num m = pow(double.parse(_mController.value.text) / 100, 2);
                              num result = num.parse(value) / m;
                              viewModel.bmi = result;
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      const Text("키"),
                      TextFormField(
                        controller: _mController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          if (value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("키를 적어주세요."),
                                    duration: Duration(seconds: 1)));
                          } else {
                            if(num.parse(value) > 220) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("몸무게를 적어주세요."),
                                      duration: Duration(seconds: 1)));
                            } else if(value.isNotEmpty && _kgController.value.text.isNotEmpty) {
                              num m = pow(double.parse(value) / 100, 2);
                              num result = num.parse(_kgController.value.text) / m;
                              viewModel.bmi = result;
                            }
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text("비만도"),
          const SizedBox(
            height: 15,
          ),
          () {
            if(viewModel.bmi >= 25.0) {
              return const Text("비만");
            } else if(viewModel.bmi >= 23.0 && viewModel.bmi <= 24.9) {
              return const Text("과체중");
            } else if(viewModel.bmi > 18.5 && viewModel.bmi <= 22.9) {
              return const Text("정상");
            } else if(viewModel.bmi >= 18.5) {
              return const Text("저체중");
            } else {
              return const Text("입력없음");
            }
          }()
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
