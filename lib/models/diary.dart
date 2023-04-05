enum Stress {
  none('https://aaa.vvv'),
  low(''),
  medium(''),
  high('');

  const Stress(this.url);

  final String url;
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
  final double sleep;
  final double bmi;
  final Stress stress;
  final List<Post> diary;

  const Diary({
    required this.id,
    required this.name,
    required this.date,
    required this.sleep,
    required this.bmi,
    required this.stress,
    required this.diary,
  });
}

class Post {
  String meal;
  String exercise;

  Post({
    required this.meal,
    required this.exercise,
  });
}
