import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/page/insert_view_model.dart';
import 'package:school_nurse_ofiice/page/login_page.dart';
import 'package:school_nurse_ofiice/page/teacher_page.dart';
import 'package:school_nurse_ofiice/page/teacher_view_model.dart';
import 'package:school_nurse_ofiice/page/todo_view.dart';
import 'package:school_nurse_ofiice/page/todo_view_model.dart';
import 'package:school_nurse_ofiice/util/customPageRoute.dart';
import 'models/argument_data.dart';
import 'page/insert_daily.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting();
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
        ChangeNotifierProvider(create: (_) => TeacherViewModel()),
      ],
      child: MaterialApp(
        initialRoute: LoginPage.routeName,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case InsertDaily.routeName:
              final args = settings.arguments as InsertDataArgs?;
              return CustomPageRoute(
                child: InsertDaily(insertData: args!),
                settings: settings,
              );
            case LoginPage.routeName:
              return MaterialPageRoute(
                builder: (context) => const LoginPage(),
              );
            case Todo.routeName:
              final args = settings.arguments as LoginArgs;
              return MaterialPageRoute(
                builder: (context) => Todo(userData: args),
              );
            case TeacherPage.routeName:
              final args = settings.arguments as LoginArgs;
              return MaterialPageRoute(
                builder: (context) => TeacherPage(userData: args),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
