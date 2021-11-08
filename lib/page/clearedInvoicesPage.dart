import 'package:athena_hack/api/firebase.dart';
import 'package:athena_hack/api/pdfAPI.dart';
import 'package:athena_hack/main.dart';
import 'package:athena_hack/widget/button_widget.dart';
import 'package:athena_hack/widget/loading.dart';
import 'package:flutter/material.dart';

class ClearedInvoicesPage extends StatefulWidget {
  @override
  _ClearedInvoicesPageState createState() => _ClearedInvoicesPageState();
}

class _ClearedInvoicesPageState extends State<ClearedInvoicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(32),
          child: FutureBuilder<List<Map<String, dynamic>>>(
              future: DS.getClearedInvoices(),
              builder: (context, snapshot) {
                return (!snapshot.hasData)
                    ? Loading()
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> element = snapshot.data![index];
                          return ButtonWidget(
                              text: element['client'] +
                                  ' @ ' +
                                  element["dueDate"].toIso8601String(),
                              onClicked: () {
                                print(element['pdfLoc']);
                                PdfApi.openPath(element['pdfLoc']);
                              });
                        },
                      );
              })),
    );
  }
}
