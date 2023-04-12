import 'dart:ui';

import 'package:school_nurse_ofiice/models/json.dart';

enum Stress {
  none('선택없음', Color(0xff000000)),
  low('좋음', Color(0xff0000ff)),
  medium('보통', Color(0xff00ff00)),
  high('나쁨', Color(0xffff0000));

  const Stress(this.url, this.color);

  final String url;
  final Color color;
}

enum Day {
  morning('아침'),
  lunch('점심'),
  diner('저녁');

  const Day(this.name);
  final String name;
}

enum DiaryTab {
  write('일기'),
  todo('오늘 한 일'),
  other('기타');

  const DiaryTab(this.name);

  final String name;
}

class Diary {
  final String id;
  final String name;
  final DateTime date;
  final String text;
  final Duration sleep;
  final num bmi;
  final Stress stress;
  final List<Post?> diary;

  const Diary({
    required this.id,
    required this.name,
    required this.date,
    required this.text,
    required this.sleep,
    required this.bmi,
    required this.stress,
    required this.diary,
  });

  factory Diary.fromJson(JSON json) {
    return Diary(
      id: 'id',
      name: 'name',
      date: DateTime.now(),
      text: json['text'],
      sleep: Duration(minutes: (json['sleep'] as double).toInt()),
      bmi: json['bmi'],
      stress: Stress.values[json['stress']],
      diary: (json['diary'] as List).map((e) => Post.fromJson(e)).toList(),
    );
  }
  JSON toJson() => {
        'id': id,
        'name': name,
        'date': date,
        'text': text,
        'sleep': sleep.inSeconds / 60,
        'bmi': bmi,
        'stress': stress.index,
        'diary': diary.map((e) => e!.toJson()).toList(),
      };
}

class Post {
  String meal;
  String exercise;

  Post({
    required this.meal,
    required this.exercise,
  });

  factory Post.fromJson(JSON json) {
    return Post(
      meal: json['meal'],
      exercise: json['exercise'],
    );
  }
  JSON toJson() => {
        'meal': meal,
        'exercise': exercise,
      };
}
