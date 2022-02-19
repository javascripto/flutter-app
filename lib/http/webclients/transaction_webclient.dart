import 'dart:io';
import 'dart:convert';

import '../webclient.dart';
import '../../models/contact.dart';
import '../../models/transaction.dart';

class TransactionWebClient {
  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting the transaction',
    401: 'authentication failed',
  };

  Future<List<Transaction>> findAll() async {
    await Future.delayed(Duration(milliseconds: 500));
    final response =
        await client.get(Uri.parse('http://localhost:8080/transactions'));
    return jsonDecode(response.body)
        .map<Transaction>((json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    if (password.isEmpty) {
      throw Exception('Senha inválida');
    }
    final response = await client.post(
      Uri.parse('http://localhost:8080/transactions'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer 123',
      },
      body: jsonEncode(transaction),
    );
    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }
    throw HttpException(
        _statusCodeResponses[response.statusCode] ?? response.reasonPhrase!);
  }
}

String formattedJsonEncode(dynamic object) {
  return JsonEncoder.withIndent('  ').convert(object);
}

main() async {
  final transactionWebClient = TransactionWebClient();

  final transaction = await transactionWebClient.save(
    Transaction(
      value: 123456.78,
      contact: Contact(
        name: 'Fulano',
        accountNumber: 1234,
      ),
    ),
    'password',
  );
  print(formattedJsonEncode(transaction));
  final transactions = await transactionWebClient.findAll();
  print(formattedJsonEncode(transactions));
}
