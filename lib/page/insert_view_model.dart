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
}
