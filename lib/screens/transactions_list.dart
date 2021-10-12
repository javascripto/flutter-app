import 'package:flutter/material.dart';

import 'package:flutter_app/http/webclient.dart';
import 'package:flutter_app/models/transaction.dart';
import 'package:flutter_app/components/centralized_loading.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: findAll(),
        builder: (context, snapshot) {
          final transactions = snapshot.data;
          if (transactions == null) return CentralizedLoading();
          return ListView.builder(
            itemCount: transactions.length,
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
          );
        },
      ),
    );
  }
}
