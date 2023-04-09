import 'package:flutter/cupertino.dart';
import 'package:school_nurse_ofiice/models/diary.dart';
import 'package:school_nurse_ofiice/page/insert_daily.dart';


class InsertViewModel extends ChangeNotifier {
  Stress _stress = Stress.none;
  Stress get stress => _stress;
  set stress(Stress s) {
    _stress = s;
    notifyListeners();
  }

  DiaryTab _tab = DiaryTab.write;
  DiaryTab get tab => _tab;
  set tab(DiaryTab t) {
    _tab = t;
    notifyListeners();
  }

  List<bool> _selected = [true, false, false, false];
  List<bool> get selector => _selected;
  set selected(int idx) {
    _selected = [false, false, false, false];
    _selected[idx] = true;
    notifyListeners();
  }

  num _bmi = 0.0;
  num get bmi => _bmi;
  set bmi(num bmiR) {
    _bmi = bmiR;
    notifyListeners();
  }

  final List<Post?> _diary = [null,null,null];
  List<Post ?> get diary => _diary;
  void setDiary(int idx, String meal, String exercise) {
    _diary[idx] = Post(meal: meal, exercise: exercise);
  }
}
