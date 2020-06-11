import 'package:flutter/material.dart';
import 'package:info_covid/models/user.dart';
import 'package:info_covid/screens/authentication/authenticate.dart';
import 'package:info_covid/screens/info/nearbylist.dart';
import 'package:provider/provider.dart';

class Nearby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate(); // se l'utente non è loggato, mostra la schermata di autenticazione
    }
    else {
      return NearbyList(); // se l'utente è loggato, mostra la schermata di Contact Tracing
    }
  }
}