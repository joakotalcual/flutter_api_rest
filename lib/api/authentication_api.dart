
import 'package:dio/dio.dart';
import 'package:flutter_api_rest/helpers/http_response.dart';
import 'package:logger/logger.dart';

class AuthenticationAPI{
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<HttpResponse> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try{
      final response = await _dio.post(
            'http://locahost:9000/api/v1/register',
            options: Options(
              headers: {
                'Content-Type': 'Aplication/json',
              },
            ),
            data: {
              "username": username,
              "email": email,
              "password": password
            }
          );
          _logger.i(response.data);

          return HttpResponse.success(response.data);
    }catch(e){
      _logger.e(e);

      int statusCode = -1223123;
      String message = "unknown error";
      dynamic data;

      if(e is DioException){ //Ya esta obsoleto el DioError
        message = e.message!;
        if(e.response != null){//No tenia acceso a internet si es nulo
          statusCode = statusCode = e.response!.statusCode!;//Convertimos de int? a int por si llega a ser nulo el statusCode o response
          message = e.response!.statusMessage!;
          data = e.response!.data!;
        }
      }

      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data
      );
    }
  }

}