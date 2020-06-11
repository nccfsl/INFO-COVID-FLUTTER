import 'package:flutter/material.dart';
import 'package:info_covid/models/user.dart';
import 'package:info_covid/services/auth.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Auth().user,
      child: MaterialApp(
        title: 'INFO COVID',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 78, 145, 228),
        ),
        home: Home(title: 'INFO COVID'),
      ),
    );
  }
}
