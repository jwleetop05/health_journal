import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/page/insert_view_model.dart';
import 'package:school_nurse_ofiice/page/todo_view.dart';
import 'package:school_nurse_ofiice/page/todo_view_model.dart';
import 'package:school_nurse_ofiice/util/providers.dart';

import 'insert_daily.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoViewModel()),
        ChangeNotifierProvider(create: (_) => InsertViewModel()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const InsertDaily(),
        },
      ),
    );
  }
}
