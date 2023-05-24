import 'package:dio/dio.dart';

const _token =
    "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWVyIjoiREVMTkkiLCJpYXQiOjE2ODQxNTg0NTcsInN1YiI6ImFnZW50LXRva2VuIn0.IHAKHugSoGWXPDuHcq5bJPkbeWa8h18t93CBBXJy6WlOAGMwX9Y0mJUXQm16UfMRnTRyJFqQV8UHAQXQqEa2Ys4-QNVsGWMjHA36N_1JdDZJ9SqEeUcKL6lRCTybUIhKOcXxnlNgZCExx31t4kHgFW_tEJ6wRTKVbaX8S2opWmA7Xlptj7qsgtRz5INAGrc6TIxxTE3Mw7SZPmy9b5ei2z_CwyRoPe1HkBIO_c__mOiibdGVJH_viros6Iczx2ko_SlPz44S3U_iG_CplZXNHcjj9WuAjfCbGmk983YFr8PLJ7k0XtDQL1xjaXRvwiu765ibcK4PcuxEejk4IhjzFw";

final httpClient = Dio()
  ..options.baseUrl = 'https://api.spacetraders.io/v2'
  ..options.headers = {'Authorization': 'Bearer $_token'};
