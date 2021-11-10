import 'package:http_interceptor/http_interceptor.dart';

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
