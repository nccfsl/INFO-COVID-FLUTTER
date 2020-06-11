import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Database {

  final String uid;
  final CollectionReference users = Firestore.instance.collection('users');

  Database({ this.uid });

  Future updateUserData(String codfisc, String email) async {
    return await users.document(uid).setData({
      'codice_fiscale': codfisc,
      'email': email,
      'positivo_covid': false
    });
  }

  Future getUserEmail() async {
    return await users.document(uid).get().then((doc) {
      String email = doc.data['email'];
      return email;
    });
  }

  void registerContact(String contactUid) async {
    bool positiveCont;
    await users.document(contactUid).get().then((doc) {
      positiveCont = doc.data['positivo_covid'];
    });

    String now = DateTime.now().toString();
    users.document(uid).collection('contacts').document(contactUid + now).setData({
      'uid': contactUid,
      'datetime': DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now()),
      'positivo_covid': positiveCont
    });
  }

  Future getContacts() async {
    return await users.document(uid).collection('contacts').getDocuments().then((snapshot) {
      return snapshot.documents;
    });
  }

  Future setPositiveState() async {
    return await users.document(uid).updateData({
      'positivo_covid': true
    });
  }

  Future getPositiveState() async {
    return await users.document(uid).get().then((doc) {
      return doc.data['positivo_covid'];
    });
  }
}