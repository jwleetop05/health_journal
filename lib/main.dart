import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/page/insert_view_model.dart';
import 'package:school_nurse_ofiice/page/login_page.dart';
import 'package:school_nurse_ofiice/page/teacher_page.dart';
import 'package:school_nurse_ofiice/page/todo_view.dart';
import 'package:school_nurse_ofiice/page/todo_view_model.dart';
import 'models/argument_data.dart';
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
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case InsertDaily.routeName:
              final args = settings.arguments as InsertDataArgs;
              MaterialPageRoute(
                builder: (context) {
                  return InsertDaily(insertData: args);
                },
              );
              break;
            case LoginPage.routeName:
              MaterialPageRoute(
                builder: (context) {
                  return const LoginPage();
                },
              );
              break;
            case Todo.routeName:
              MaterialPageRoute(
                builder: (context) {
                  return const Todo();
                },
              );
              break;
            case TeacherPage.routeName:
              MaterialPageRoute(
                builder: (context) {
                  return const TeacherPage();
                },
              );
              break;
          }
        },
      ),
    );
  }
}
