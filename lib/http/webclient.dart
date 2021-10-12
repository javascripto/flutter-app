import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';

import '../models/transaction.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  interceptRequest({required RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  interceptResponse({required ResponseData data}) async {
    print(data.toString());
    return data;
  }
}

Future<List<Transaction>> findAll() async {
  final client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);

  final response =
      await client.get(Uri.parse('http://localhost:8080/transactions'));
  return jsonDecode(response.body)
      .map<Transaction>((json) => Transaction.fromJson(json))
      .toList();
}

String formattedJsonEncode(dynamic object) {
  return JsonEncoder.withIndent('  ').convert(object);
}

main() async {
  final transactions = await findAll();
  print(formattedJsonEncode(transactions));
}
