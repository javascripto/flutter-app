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

String formattedJsonEncode(dynamic object) {
  return JsonEncoder.withIndent('  ').convert(object);
}

main() async {
  final transactions = await findAll();
  print(formattedJsonEncode(transactions));
}
