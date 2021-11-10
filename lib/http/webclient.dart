import 'dart:io';
import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter_app/http/interceptors/logging_interceptor.dart';

import '../models/contact.dart';
import '../models/transaction.dart';

final client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);

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
    body: jsonEncode({
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber,
      },
    }),
  );
  return Transaction.fromJson(jsonDecode(response.body));
}

String formattedJsonEncode(dynamic object) {
  return JsonEncoder.withIndent('  ').convert(object);
}

main() async {
  final transaction = await save(Transaction(
    value: 123456.78,
    contact: Contact(
      name: 'Fulano',
      accountNumber: 1234,
    ),
  ));
  print(formattedJsonEncode(transaction));
  final transactions = await findAll();
  print(formattedJsonEncode(transactions));
}
