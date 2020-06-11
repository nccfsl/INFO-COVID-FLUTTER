import 'package:flutter/material.dart';
import 'package:info_covid/models/user.dart';
import 'package:info_covid/screens/authentication/authenticate.dart';
import 'package:info_covid/screens/userdatapage.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    Widget pageShown;

    if (user == null) {
      pageShown = Authenticate();
    }
    else {
      pageShown = UserData(userUid: user.uid);
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor, //change your color here
        ),
        backgroundColor: Colors.transparent,
        title: Text('UTENTE',
          style: TextStyle(
            color: Theme.of(context).primaryColor)
        ),
        elevation: 0.0,
      ),
      body: pageShown,
    );
  }
}