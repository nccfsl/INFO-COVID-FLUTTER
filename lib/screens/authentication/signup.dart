import 'package:flutter/material.dart';
import 'package:info_covid/services/auth.dart';
import 'package:info_covid/shared/loading.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final Auth _auth = Auth();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String codfisc = '', email = '', pw = '', error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor, //change your color here
        ),
        title: Text('REGISTRATI',
          style: TextStyle(color: Theme.of(context).primaryColor)
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) => value.length != 16 ? 'Inserisci un codice fiscale valido' : null,
                    onChanged: (value) {
                      setState(() => codfisc = value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Codice fiscale',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
                      )
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) => value.isEmpty ? 'Inserisci una mail valida' : null,
                    onChanged: (value) {
                      setState(() => email = value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
                      )
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) => value.length < 6 ? 'Inserisci una password di almeno 6 caratteri' : null,
                    onChanged: (value) {
                      setState(() => pw = value);
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
                      )
                    ),
                  ),
                  SizedBox(height: 20.0),
                  FlatButton(
                    child: Text('Registrati',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);

                        dynamic result = await _auth.signupEmailPw(codfisc, email, pw);
                        if (result == null) {
                          setState(() {
                            error = 'Inserisci una mail valida';
                            loading = false;
                          }); // fare una snackbar
                        }
                        else {
                          setState(() => error = '');
                          Navigator.pop(context);
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(error, 
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}