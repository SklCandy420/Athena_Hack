import 'package:athena_hack/model/customer.dart';
import 'package:athena_hack/model/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  String description;
  int quantity;
  double gst;
  double unitPrice;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.gst,
    required this.unitPrice,
  });
}
