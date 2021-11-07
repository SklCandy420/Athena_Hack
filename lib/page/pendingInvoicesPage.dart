import 'package:flutter/material.dart';
import 'package:generate_pdf_invoice_example/api/firebase.dart';
import 'package:generate_pdf_invoice_example/api/pdf_api.dart';
import 'package:generate_pdf_invoice_example/main.dart';
import 'package:generate_pdf_invoice_example/widget/button_widget.dart';

class PendingInvoicesPage extends StatefulWidget {
  @override
  _PendingInvoicesPageState createState() => _PendingInvoicesPageState();
}

class _PendingInvoicesPageState extends State<PendingInvoicesPage> {
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
              future: DS.getPendingInvoices(),
              builder: (context, snapshot){
                return (!snapshot.hasData)? Text("LOADING", style: TextStyle(color: Colors.white)) : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    Map<String, dynamic> element = snapshot.data![index];
                    return Row(
                      children: [
                        Expanded(child: ButtonWidget(text: element['client'] + ' @ ' + element["dueDate"].toIso8601String(), onClicked: (){
                            print(element['pdfLoc']);
                            PdfApi.openPath(element['pdfLoc']);
                          }),),
                        IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: (){
                          DS.clearPending(element['uri']);
                        }),
                      ],
                    );
                  },
                );
              }
          )
      ),
    );
  }
}