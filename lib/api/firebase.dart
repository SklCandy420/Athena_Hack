import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';


class DatabaseService{
  CollectionReference _invoice = FirebaseFirestore.instance.collection("invoices");
  Reference storageRef = FirebaseStorage.instance.ref();
  Future<String> addInvoice(String client, DateTime dueDate, File pdf) async {
    String name = Uuid().v4();
    Reference locRef = storageRef.child('invoices/' + name);
    await locRef.putFile(pdf);
    String dloadurl = await locRef.getDownloadURL();
    await _invoice.add({
      "client": client,
      "dueDate": dueDate,
      "pdfLoc": dloadurl,
      'cleared': false,
    });
    return dloadurl;
  }
  Future<List<Map<String, dynamic>>> getClearedInvoices() async {
    QuerySnapshot docs = await _invoice.where('cleared', isEqualTo: true).orderBy('dueDate').get();
    List<Map<String, dynamic>> returnedDocs = [];
    docs.docs.forEach((element) {
      returnedDocs.add({
        "client": element.data()['client'],
        "dueDate": DateTime.parse(element.data()['dueDate'].toDate().toString()),
        "pdfLoc": element.data()['pdfLoc'],
        'cleared': element.data()['cleared'],
      });
    });
    return returnedDocs;
  }

  Future<List<Map<String, dynamic>>> getPendingInvoices() async {
    QuerySnapshot docs = await _invoice.where('cleared', isEqualTo: false).orderBy('dueDate').get();
    List<Map<String, dynamic>> returnedDocs = [];
    docs.docs.forEach((element) {
      returnedDocs.add({
        "client": element.data()['client'],
        "dueDate": DateTime.parse(element.data()['dueDate'].toDate().toString()),
        "pdfLoc": element.data()['pdfLoc'],
        'cleared': element.data()['cleared'],
        'uri': element.id,
      });
    });
    return returnedDocs;
  }

  Future<bool> clearPending(String id) async {
    await _invoice.doc(id).update({
      'cleared': true,
    });
    return true;
  }

}

DatabaseService DS = new DatabaseService();