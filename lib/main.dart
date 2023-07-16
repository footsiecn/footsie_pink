import 'dart:convert';

import 'package:footsie/constants.dart';
import 'package:footsie/screens/chats/chats_screen.dart';
import 'package:footsie/screens/login/login.dart';
import 'package:footsie/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Instances.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final u = jsonDecode(Instances.sp.getString('userinfo') ?? '');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: u != null ? ChatsScreen() : Login(),
    );
  }
}
