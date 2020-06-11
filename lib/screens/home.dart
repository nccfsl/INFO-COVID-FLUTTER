import 'package:flutter/material.dart';
import 'package:info_covid/models/covidclasses.dart';
import 'package:info_covid/screens/userpage.dart';
import 'package:info_covid/services/coviddata.dart';
import 'package:info_covid/screens/info/nearby.dart';
import 'package:info_covid/screens/info/regional.dart';
import 'package:info_covid/screens/info/national.dart';
import 'package:info_covid/animations/pageanim.dart';
import 'package:info_covid/shared/splash.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  static List<Andamento> listAnd = List<Andamento>();
  static List<Regione> listReg = List<Regione>();
  static List<Provincia> listProv = List<Provincia>();
  static List<String> nomiRegioni = List<String>();
  Widget nearbyPage = Nearby();
  bool ready_1 = false, ready_2 = false, ready_3 = false, ready_4 = false;

  void _onItemTapped(int index) { // cambia indice alla pressione di un tasto della bottom navigation
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToUserPage() { // naviga alla pagina Utente
    Navigator.push(context, PageAnim.createRoute(UserPage()));
  }

  List<Widget> _pages() => [
    nearbyPage,
    Regional(nomiRegioni: nomiRegioni, regioni: listReg, province: listProv),
    National(listAnd: listAnd)
  ];

  @override
  void initState() {
    CovidData.getAndamento().then((value) { // esegue la query all'API e inserisce i dati in una lista di Andamento
      setState(() {
        listAnd = value;
        ready_1 = true;
      });
    });
    CovidData.getRegioni().then((value) { // esegue la query all'API e inserisce i dati in una lista di Regione
      setState(() {
        listReg = value;
        ready_2 = true;
      });
    });
    CovidData.getNomiRegioni().then((value) {
      setState(() {
        nomiRegioni = value;
        ready_3 = true;
      });
    });
    CovidData.getProvince().then((value) {
      setState(() {
        listProv = value;
        ready_4 = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pages = _pages();

    if (ready_1 && ready_2 && ready_3 && ready_4) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
            style: TextStyle(color: Theme.of(context).primaryColor)
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: _navigateToUserPage,
              color: Theme.of(context).primaryColor,
              tooltip: 'Pagina utente',
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.trip_origin),
              title: Text('Tracing'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Regionale'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_city),
              title: Text('Nazionale'),
            ),
          ],
          showUnselectedLabels: false,
          elevation: 0.0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
    }
    else {
      return SplashScreen();
    }
  }
}