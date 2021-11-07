import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DatabaseService{
  CollectionReference _invoice = FirebaseFirestore.instance.collection("invoices");
  Reference storageRef = FirebaseStorage.instance.ref();
  Future<bool> addInvoice(String client, DateTime dueDate, File pdf) async {
    List name = pdf.path.split('/');
    Reference locRef = storageRef.child('invoices/' + name[name.length-1]);
    await locRef.putFile(pdf);
    await _invoice.add({
      "client": client,
      "dueDate": dueDate,
      "pdfLoc": await locRef.getDownloadURL(),
    });
    return true;
  }
}

DatabaseService ds = new DatabaseService();