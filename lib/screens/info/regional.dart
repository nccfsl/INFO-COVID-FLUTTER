import 'package:flutter/material.dart';
import 'package:info_covid/animations/pageanim.dart';
import 'package:info_covid/models/covidclasses.dart';
import 'package:info_covid/screens/info/regional-detail.dart';

class Regional extends StatefulWidget {

  final List<String> nomiRegioni;
  final List<Regione> regioni;
  final List<Provincia> province;

  Regional({ this.regioni, this.nomiRegioni, this.province });

  @override
  _RegionalState createState() => _RegionalState();
}

class _RegionalState extends State<Regional> {

  String _selectedItem = null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius:BorderRadius.all(Radius.circular(4.0)),
              border: Border.all(width: 2.0, color: Theme.of(context).primaryColor)
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text("Seleziona regione"),
                value: _selectedItem,
                items: widget.nomiRegioni.map((regione) {
                  return DropdownMenuItem(
                    value: regione,
                    child: Text(regione),
                  );
                }).toList(),
                onChanged: (item) {
                  setState(() {
                    _selectedItem = item;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20.0),
          FlatButton(
            child: Text('Visualizza dati',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () {
              if (_selectedItem != null)
                Navigator.push(context, PageAnim.createRoute(RegionalDetail(nomeRegione: _selectedItem, datiRegioni: widget.regioni, datiProvince: widget.province)));
            },
          )
        ],
      )
    );
  }
}