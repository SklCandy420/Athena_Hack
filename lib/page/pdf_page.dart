import 'dart:io';
import 'package:athena_hack/api/firebase.dart';
import 'package:athena_hack/api/pdf_api.dart';
import 'package:athena_hack/api/pdf_invoice_api.dart';
import 'package:athena_hack/main.dart';
import 'package:athena_hack/model/customer.dart';
import 'package:athena_hack/model/invoice.dart';
import 'package:athena_hack/model/supplier.dart';
import 'package:athena_hack/widget/button_widget.dart';
import 'package:athena_hack/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  String sName = '';
  String sAddr = '';
  String sPaym = '';
  String sEmil = '';
  String cName = '';
  String cAddr = '';
  String cEmil = '';
  File? pdfFile;
  DateTime dueDate = DateTime.now();
  List<InvoiceItem> invItems = [];
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            invItems.add(InvoiceItem(
                description: '', quantity: 0, gst: 0.0, unitPrice: 0.0));
            setState(() {});
          },
        ),
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleWidget(
                  text: 'Supplier Info',
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      style: TextStyle(color: Colors.white),
                      onChanged: (val) {
                        sName = val;
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      style: TextStyle(color: Colors.white),
                      onChanged: (val) {
                        sAddr = val;
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Payment Info',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      style: TextStyle(color: Colors.white),
                      onChanged: (val) {
                        sPaym = val;
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      style: TextStyle(color: Colors.white),
                      onChanged: (val) {
                        sEmil = val;
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                TitleWidget(
                  text: 'Customer Info',
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      style: TextStyle(color: Colors.white),
                      onChanged: (val) {
                        cName = val;
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      style: TextStyle(color: Colors.white),
                      onChanged: (val) {
                        cAddr = val;
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      style: TextStyle(color: Colors.white),
                      onChanged: (val) {
                        cEmil = val;
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                TitleWidget(
                  text: 'Invoice Items',
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: invItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Item No " + (index + 1).toString() + " : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    decoration: InputDecoration(
                                        labelText: 'Description',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white))),
                                    style: TextStyle(color: Colors.white),
                                    onChanged: (val) {
                                      invItems[index].description = val;
                                    },
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                      child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Quantity',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white))),
                                    style: TextStyle(color: Colors.white),
                                    onChanged: (val) {
                                      invItems[index].quantity = int.parse(val);
                                    },
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                      child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Unit Price',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white))),
                                    style: TextStyle(color: Colors.white),
                                    onChanged: (val) {
                                      invItems[index].unitPrice =
                                          double.parse(val);
                                    },
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                      child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'GST',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white))),
                                    style: TextStyle(color: Colors.white),
                                    onChanged: (val) {
                                      invItems[index].gst = double.parse(val);
                                    },
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Center(
                  child: ButtonWidget(
                    text: 'Invoice PDF',
                    onClicked: () async {
                      final date = DateTime.now();
                      dueDate = date.add(Duration(days: 7));

                      final invoice = Invoice(
                        supplier: Supplier(
                          name: sName,
                          address: sAddr,
                          paymentInfo: sPaym,
                          emailAddress: sEmil,
                        ),
                        customer: Customer(
                          name: cName,
                          address: cAddr,
                          emailAddress: cEmil,
                        ),
                        info: InvoiceInfo(
                          date: date,
                          dueDate: dueDate,
                          number: '${DateTime.now().year}-9999',
                        ),
                        items: invItems,
                      );

                      pdfFile = await PdfInvoiceApi.generate(invoice);

                      PdfApi.openFile(pdfFile!);
                    },
                  ),
                ),
                Center(
                  child: ButtonWidget(
                    text: 'Mail Invoice',
                    onClicked: () async {
                      print("HERE");
                      if (pdfFile == null) {
                        print("PDF NULL");
                      } else {
                        String link =
                            await DS.addInvoice(cName, dueDate, pdfFile!);
                        String url = 'mailto:' +
                            cEmil +
                            '?subject=Invoice from ' +
                            sName +
                            '&body=Please find the latest invoice at ' +
                            link;
                        await canLaunch(url)
                            ? await launch(url)
                            : print("error launching url");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
