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

  final List<bool> _selected = [true, false, false, false];
  List<bool> get selector => _selected;
  set selected(int idx) {
    for(int i = 0; i < _selected.length; i++) {
      if(idx != i) {
        _selected[i] = false;
      } else {
        _selected[i] = true;
        _stress = Stress.values[i];
      }
    }
    notifyListeners();
  }
}
