import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:info_covid/models/covidclasses.dart';
import 'package:auto_size_text/auto_size_text.dart';

class National extends StatefulWidget {

  final List<Andamento> listAnd;
  National({ this.listAnd });

  @override
  _NationalState createState() => _NationalState();
}

class _NationalState extends State<National> {

  final textGroup = AutoSizeGroup();

  List<charts.Series<Andamento, DateTime>> _datiAndamento() {
    final data = widget.listAnd;

    return [
      new charts.Series<Andamento, DateTime>(
        id: 'Totale positivi',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Andamento and, _) => and.data,
        measureFn: (Andamento and, _) => and.totale_positivi,
        data: data,
      ),
      new charts.Series<Andamento, DateTime>(
        id: 'Guariti',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Andamento and, _) => and.data,
        measureFn: (Andamento and, _) => and.guariti,
        data: data,
      ),
      new charts.Series<Andamento, DateTime>(
        id: 'Deceduti',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Andamento and, _) => and.data,
        measureFn: (Andamento and, _) => and.deceduti,
        data: data,
      )
    ];
  }

  List<charts.Series<Andamento, DateTime>> _datiNuoviPositivi() {
    final data = widget.listAnd;

    return [
      new charts.Series<Andamento, DateTime>(
        id: 'Nuovi positivi giornalieri',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Andamento and, _) => and.data,
        measureFn: (Andamento and, _) => and.variazione_totale_positivi,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  child: InfoCard(title: 'Attualmente positivi', value: widget.listAnd.last.totale_positivi, titleColor: Colors.amber),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: InfoCard(title: 'Guariti', value: widget.listAnd.last.guariti, titleColor: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: InfoCard(title: 'Deceduti', value: widget.listAnd.last.deceduti, titleColor: Colors.red),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: InfoCard(title: 'Totale positivi', value: widget.listAnd.last.totale_positivi + widget.listAnd.last.guariti + widget.listAnd.last.deceduti, titleColor: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            AutoSizeText(
              'Grafico andamento nazionale',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 12.0,
              maxFontSize: 18.0,
              maxLines: 1,
              group: textGroup,
            ),
            SizedBox(
              height: 230.0,
              child: new charts.TimeSeriesChart(
                _datiAndamento(),
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                behaviors: [new charts.SeriesLegend()],
              ),
            ),
            SizedBox(
              height: 25.0
            ),
            AutoSizeText(
              'Nuovi positivi giornalieri',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 12.0,
              maxFontSize: 18.0,
              maxLines: 1,
              group: textGroup,
            ),
            SizedBox(
              height: 230.0,
              child: new charts.TimeSeriesChart(
                _datiNuoviPositivi(),
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                // behaviors: [new charts.SeriesLegend()],
              ),
            ),
          ],
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