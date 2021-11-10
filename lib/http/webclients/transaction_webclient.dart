import 'dart:io';
import 'dart:convert';

import '../webclient.dart';
import '../../models/contact.dart';
import '../../models/transaction.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    await Future.delayed(Duration(milliseconds: 500));
    final response = await client
        .get(Uri.parse('http://localhost:8080/transactions'))
        .timeout(Duration(seconds: 5));
    return jsonDecode(response.body)
        .map<Transaction>((json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final response = await client.post(
      Uri.parse('http://localhost:8080/transactions'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer 123',
      },
      body: _transactionToJson(transaction),
    );
    return Transaction.fromJson(jsonDecode(response.body));
  }

  String _transactionToJson(Transaction transaction) {
    return jsonEncode({
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber,
      },
    });
  }
}

String formattedJsonEncode(dynamic object) {
  return JsonEncoder.withIndent('  ').convert(object);
}

main() async {
  final transactionWebClient = TransactionWebClient();

  final transaction = await transactionWebClient.save(Transaction(
    value: 123456.78,
    contact: Contact(
      name: 'Fulano',
      accountNumber: 1234,
    ),
  ));
  print(formattedJsonEncode(transaction));
  final transactions = await transactionWebClient.findAll();
  print(formattedJsonEncode(transactions));
}