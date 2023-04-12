import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/page/insert_view_model.dart';
import 'package:school_nurse_ofiice/page/login_page.dart';
import 'package:school_nurse_ofiice/page/teacher_page.dart';
import 'package:school_nurse_ofiice/page/todo_view.dart';
import 'package:school_nurse_ofiice/page/todo_view_model.dart';
import 'page/insert_daily.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/todo': (context) => const Todo(),
          '/insert': (context) => const InsertDaily(),
          '/teacher': (context) => const TeacherPage(),
        },
      ),
    );
  }
}
