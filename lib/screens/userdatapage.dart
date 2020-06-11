import 'package:flutter/material.dart';
import 'package:info_covid/services/auth.dart';
import 'package:info_covid/services/database.dart';

class UserData extends StatefulWidget {

  final userUid;
  UserData({ this.userUid });

  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {

  final Auth _auth = Auth();
  String _userEmail = 'email';
  bool _positive = false;

  void logOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Log Out"),
          content: Text("Confermi di voler eseguire il log out?"),
          actions: <Widget>[
            FlatButton(
              child: new Text("ANNULLA"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("CONFERMA"),
              onPressed: () async {
                await _auth.logOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void setPositive(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Conferma positività'),
          content: Text('Sei sicuro di voler confermare la positività? Questa verrà notificata agli altri utenti'),
          actions: <Widget>[
            FlatButton(
              child: new Text("ANNULLA"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("CONFERMA"),
              onPressed: () async {
                await Database(uid: widget.userUid).setPositiveState();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  void initState() {
    Database(uid: widget.userUid).getUserEmail().then((email) {
      setState(() {
        _userEmail = email;
      });
    });
    Database(uid: widget.userUid).getPositiveState().then((positiveState) {
      setState(() {
        _positive = positiveState;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    String posText = _positive ? 'Positivo' : 'Non positivo';

    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                width: 3.0,
                color: Colors.grey[200]
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Card(
              elevation: 0.0,
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(widget.userUid),
                    subtitle: Text('${_userEmail} - ${posText}'),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('LOG OUT',
                          style: TextStyle(color: Colors.red)
                        ),
                        onPressed: () {
                          logOutDialog(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.0),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                width: 3.0,
                color: Colors.grey[200]
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Card(
              elevation: 0.0,
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(_positive ? 'Hai notificato la tua positività' : 'Sei risultato positivo?'),
                    subtitle: Text(_positive ? 'La tua positività è stata notificata al server' : 'Clicca SONO POSITIVO per notificare la tua positività al server'),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('Sono positivo',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                        onPressed:_positive ? null : () {
                          setPositive(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}