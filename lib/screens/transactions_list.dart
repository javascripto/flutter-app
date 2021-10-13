import 'package:flutter/material.dart';
import 'package:flutter_app/components/centered_message.dart';

import 'package:flutter_app/http/webclient.dart';
import 'package:flutter_app/models/transaction.dart';
import 'package:flutter_app/components/centered_loading.dart';

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
          print(transactions);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return CenteredLoading();
            case ConnectionState.done:
            default:
          }
          if (transactions == null || transactions.isEmpty) {
            return CenteredMessage(
              'No transactions found',
              icon: Icons.warning,
            );
          }
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
