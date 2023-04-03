import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:school_nurse_ofiice/page/todo_view_model.dart';

final _providers = <ChangeNotifier>[
  TodoViewModel(),
];

List<ChangeNotifierProvider> get providers =>
    _providers.map((vm) => ChangeNotifierProvider(create: (_) => vm)).toList();
