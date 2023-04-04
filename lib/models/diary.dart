enum Stress { none, low, medium, high }

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
