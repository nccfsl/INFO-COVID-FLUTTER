import 'package:auto_size_text/auto_size_text.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:info_covid/models/covidclasses.dart';

class RegionalDetail extends StatefulWidget {

  final String nomeRegione;
  final List<Regione> datiRegioni;
  final List<Provincia> datiProvince;

  RegionalDetail({ this.nomeRegione, this.datiRegioni, this.datiProvince });

  @override
  _RegionalDetailState createState() => _RegionalDetailState();
}

class _RegionalDetailState extends State<RegionalDetail> {

  List<charts.Series<Provincia, String>> _datiProvince() {
    final data = List<Provincia>.from(widget.datiProvince);

    data.removeWhere((element) => element.nome_regione != widget.nomeRegione);

    return [
      new charts.Series<Provincia, String> (
        id: 'Totale casi',
        domainFn: (Provincia prov, _) => prov.nome,
        measureFn: (Provincia prov, _) => prov.totcasi,
        data: data,
        labelAccessorFn: (Provincia prov, _) => '${prov.nome}: ${prov.totcasi}'
      )
    ];
  }

  @override
  Widget build(BuildContext context) {

    final data = List<Regione>.from(widget.datiRegioni);
    data.removeWhere((element) => element.nome != widget.nomeRegione);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor, //change your color here
        ),
        backgroundColor: Colors.transparent,
        title: Text(widget.nomeRegione.toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).primaryColor)
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: InfoCard(title: 'Attualmente positivi', value: data.last.totale_positivi, titleColor: Colors.amber),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: InfoCard(title: 'Guariti', value: data.last.guariti, titleColor: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: InfoCard(title: 'Deceduti', value: data.last.deceduti, titleColor: Colors.red),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: InfoCard(title: 'Totale positivi', value: data.last.totale_positivi + data.last.guariti + data.last.deceduti, titleColor: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              AutoSizeText(
                'Totale casi province ${widget.nomeRegione}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                minFontSize: 12.0,
                maxFontSize: 18.0,
                maxLines: 1,
              ),
              SizedBox(
                height: 230.0,
                child: charts.BarChart(
                  _datiProvince(),
                  animate: true,
                  vertical: false,
                  // Set a bar label decorator.
                  barRendererDecorator: new charts.BarLabelDecorator<String>(),
                  // Hide domain axis.
                  domainAxis: new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {

  final String title;
  final int value;
  final Color titleColor;

  InfoCard({ this.title, this.value, this.titleColor });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        child: SizedBox(
          height: 80.0,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(child: AutoSizeText('$title', style: TextStyle(color: titleColor), minFontSize: 4.0, maxLines: 1,)),
                  Expanded(
                    child: AutoSizeText('$value',
                      style: TextStyle(fontSize: 30.0),
                      minFontSize: 12.0,
                      maxFontSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}