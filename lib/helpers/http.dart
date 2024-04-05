// Importa la definición de la clase Dio para realizar solicitudes HTTP
import 'package:dio/dio.dart';
// Importa la definición de la clase HttpResponse para manejar respuestas HTTP
import 'package:flutter_api_rest/helpers/http_response.dart';
// Importa la utilidad de logs para registrar información y errores
import 'package:flutter_api_rest/utils/logs.dart';

// Clase para manejar las solicitudes HTTP
class Http {
  late Dio _dio; // Instancia de la clase Dio para realizar solicitudes HTTP
  late bool _logsEnable; // Variable para habilitar o deshabilitar los logs de la clase

  // Constructor de la clase Http
  Http({
    required Dio dio, // Parámetro obligatorio para la instancia de Dio
    required bool logsEnable, // Parámetro obligatorio para habilitar los logs
  }) {
    _dio = dio; // Asigna la instancia de Dio proporcionada al atributo _dio
    _logsEnable = logsEnable; // Asigna el valor de logsEnable al atributo _logsEnable
  }

  // Método para realizar una solicitud HTTP
  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = 'GET', // Método HTTP por defecto: GET
    Map<String, dynamic>? queryParameters, // Parámetros de consulta opcionales
    Map<String, dynamic>? data, // Datos de solicitud opcionales
    Map<String, dynamic>? formData, // Datos de formulario opcionales
    Map<String, dynamic>? headers, // Cabeceras opcionales
    T Function(dynamic data)? parser, // Función de análisis opcional para procesar la respuesta
  }) async {
    try {
      // Realiza la solicitud HTTP utilizando la instancia de Dio
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: formData != null? FormData.fromMap(formData) : data, // Convierte los datos de formulario a FormData si formData no es nulo
      );
      Logs.p.i(response.data); // Registra la respuesta en los logs

      // Si hay una función de análisis, se utiliza para procesar la respuesta
      if (parser != null) {
        return HttpResponse.success<T>(parser(response.data)); // Retorna una respuesta HTTP exitosa con los datos analizados
      }

      return HttpResponse.success<T>(response.data); // Retorna una respuesta HTTP exitosa con los datos de la respuesta original
    } catch (e) {
      Logs.p.e(e); // Registra cualquier error en los logs

      int statusCode = 0; // Código de estado por defecto: 0
      String message = 'unknown error'; // Mensaje de error por defecto: 'unknown error'
      dynamic data; // Datos de error

      // Manejo de errores específicos de la clase DioError
      if (e is DioError) {
        statusCode = -1; // Establece el código de estado a -1 para indicar un error de red
        message = e.message.toString(); // Obtiene el mensaje de error
        if (e.response != null) {
          statusCode = e.response!.statusCode!; // Obtiene el código de estado de la respuesta
          message = e.response!.statusMessage!; // Obtiene el mensaje de estado de la respuesta
          data = e.response!.data; // Obtiene los datos de la respuesta
        }
      }
      // Retorna una respuesta HTTP con un error
      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
