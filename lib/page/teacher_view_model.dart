import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';

class TeacherViewModel extends ChangeNotifier {
  static final DateTime _now = DateTime.now() ;
  DateTime get now => _now;
  DateTime _selectDay = DateTime(_now.year, _now.month, _now.day);
  DateTime get selectDay => _selectDay;
  set selectDay(DateTime day) {
    _selectDay = day;
    notifyListeners();
  }
  DateTime _focusDay = _now;
  DateTime get focusDay => _focusDay;
  set focusDay(DateTime day) {
    _focusDay = day;
    notifyListeners();
  }
}