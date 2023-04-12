import 'package:flutter/cupertino.dart';
import 'package:school_nurse_ofiice/page/insert_daily.dart';

class TodoViewModel extends ChangeNotifier {
  int _day = 0;
  int get day => _day;
  set day(int i) {
    _day = i;
    notifyListeners();
  }
}
