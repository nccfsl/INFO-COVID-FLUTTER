import 'package:flutter/material.dart';
import 'package:info_covid/animations/pageanim.dart';
import 'package:info_covid/screens/authentication/login.dart';
import 'package:info_covid/screens/authentication/signup.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text('Login',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () {
              Navigator.push(context, PageAnim.createRoute(Login()));
            },
          ),
          SizedBox(height: 20.0),
          Text('oppure', style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
          SizedBox(height: 20.0),
          FlatButton(
            child: Text('Registrati',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () {
              Navigator.push(context, PageAnim.createRoute(SignUp()));
            },
          )
        ],
      )
    );
  }
}