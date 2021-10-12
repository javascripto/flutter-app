import 'package:flutter_app/models/contact.dart';

class Transaction {
  late final String? id;
  final double value;
  final Contact contact;
  late final String? dateTime;

  Transaction(
      {this.id, this.dateTime, required this.value, required this.contact});

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value'],
        dateTime = json['dateTime'],
        contact = Contact.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'contact': contact.toJson(),
        'dateTime': dateTime,
      };

  @override
  String toString() {
    return 'Transaction {id: $id, value: $value, contact: $contact, dateTime: $dateTime}';
  }
}
