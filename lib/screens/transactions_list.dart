import 'package:flutter/material.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    transactions.add(Transaction(
      value: 100.00,
      contact: Contact(name: 'Alex', accountNumber: 1000),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final Transaction transaction = transactions[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text(
                transaction.value.toString(),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                transaction.contact.accountNumber.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
