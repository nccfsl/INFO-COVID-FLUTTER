
class Andamento {
  DateTime data;
  int ricoverati;
  int terapia_intensiva;
  int isolamento;
  int totale_positivi;
  int variazione_totale_positivi;
  int guariti;
  int deceduti;
  int tamponi;

  Andamento({ this.data, this.ricoverati, this.terapia_intensiva, this.isolamento, this.totale_positivi, this.variazione_totale_positivi, this.guariti, this.deceduti, this.tamponi });
}

class Regione {
  String nome;
  int codice;
  DateTime data;
  int ricoverati;
  int terapia_intensiva;
  int isolamento;
  int totale_positivi;
  int guariti;
  int deceduti;
  int tamponi;

  Regione({ this.nome, this.codice, this.data, this.ricoverati, this.terapia_intensiva, this.isolamento, this.totale_positivi, this.guariti, this.deceduti, this.tamponi });
}

class Provincia {
  String nome;
  int codice;
  int codice_regione;
  String nome_regione;
  DateTime data;
  int totcasi;

  Provincia({ this.nome, this.codice, this.codice_regione, this.nome_regione, this.data, this.totcasi });
}