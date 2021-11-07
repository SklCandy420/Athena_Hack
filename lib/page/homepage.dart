import 'package:athena_hack/main.dart';
import 'package:athena_hack/page/clearedInvoicesPage.dart';
import 'package:athena_hack/page/pdf_page.dart';
import 'package:athena_hack/page/pendingInvoicesPage.dart';
import 'package:athena_hack/widget/button_widget.dart';
import 'package:athena_hack/widget/title_widget.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleImageWidget(
                icon: Icons.picture_as_pdf_rounded, text: "Invoice app"),
            ButtonWidget(
                text: "New Invoice",
                onClicked: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PdfPage()));
                }),
            ButtonWidget(
                text: "Cleared Invoices",
                onClicked: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClearedInvoicesPage()));
                }),
            ButtonWidget(
                text: "Pending invoices",
                onClicked: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PendingInvoicesPage()));
                }),
          ],
        ),
      ),
    );
  }
}
