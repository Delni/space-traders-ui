import 'package:dio/dio.dart';

final httpClient = Dio()..options.baseUrl = 'https://api.spacetraders.io/v2';

R getDataAs<R>(Response value) => value.data["data"] as R;
String getErrorMessage(DioError error) =>
    error.response?.data['error']['message'];

void saveToken(String token) {
  httpClient.options.headers = {'Authorization': 'Bearer $token'};
}
