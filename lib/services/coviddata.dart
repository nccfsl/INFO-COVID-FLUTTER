import 'package:info_covid/models/covidclasses.dart';
import 'package:http/http.dart';
import 'dart:convert';

class CovidData {
  // prende i dati dell'andamento nazionale
  static Future<List<Andamento>> getAndamento() async {
    List<Andamento> list = List<Andamento>();

    /* Response response = await get('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json'); */
    Response response = await get('https://fasolo-covid-19.herokuapp.com/index.php/api/andamento');
    List data = jsonDecode(response.body);

    for (Map and in data) {
      list.add(Andamento(
        data: DateTime.parse(and['data']),
        ricoverati: int.parse(and['ricoverati_con_sintomi']),
        terapia_intensiva: int.parse(and['terapia_intensiva']),
        isolamento: int.parse(and['isolamento_domiciliare']),
        totale_positivi: int.parse(and['totale_positivi']),
        variazione_totale_positivi: int.parse(and['variazione_totale_positivi']),
        guariti: int.parse(and['dimessi_guariti']),
        deceduti: int.parse(and['deceduti']),
        tamponi: int.parse(and['tamponi'])
      ));
    }

    return list;
  }

  // prende i dati di ogni singola regione
  static Future<List<Regione>> getRegioni() async {
    List<Regione> list = List<Regione>();

    Response response = await get('https://fasolo-covid-19.herokuapp.com/index.php/api/regioni');
    List data = jsonDecode(response.body);

    for (Map reg in data) {
      list.add(Regione(
        nome: reg['denominazione_regione'],
        codice: int.parse(reg['codice_regione']),
        data: DateTime.parse(reg['data']),
        ricoverati: int.parse(reg['ricoverati_con_sintomi']),
        terapia_intensiva: int.parse(reg['terapia_intensiva']),
        isolamento: int.parse(reg['isolamento_domiciliare']),
        totale_positivi: int.parse(reg['totale_positivi']),
        guariti: int.parse(reg['dimessi_guariti']),
        deceduti: int.parse(reg['deceduti']),
        tamponi: int.parse(reg['tamponi'])
      ));
    }

    return list;
  }
  
  static Future<List<Provincia>> getProvince() async {
    List<Provincia> list = List<Provincia>();

    Response response = await get('https://fasolo-covid-19.herokuapp.com/index.php/api/province');
    List data = jsonDecode(response.body);

    for (Map prov in data) {
      list.add(Provincia(
        nome: prov['denominazione_provincia'],
        codice: int.parse(prov['codice_provincia']),
        codice_regione: int.parse(prov['codice_regione']),
        nome_regione: prov['denominazione_regione'],
        data: DateTime.parse(prov['data']),
        totcasi: int.parse(prov['totale_casi'])
      ));
    }

    return list;
  }

  // prende i nomi di ogni regione
  static Future<List<String>> getNomiRegioni() async {
    List<Regione> list = await getRegioni();
    List<String> regioniList = [];

    for (Regione reg in list) {
      if (regioniList.contains(reg.nome)) {
        continue;
      }
      regioniList.add(reg.nome);
    }

    regioniList.sort();

    return regioniList;
  }
}