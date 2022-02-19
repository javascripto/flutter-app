import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter_app/http/interceptors/logging_interceptor.dart';

final client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);
