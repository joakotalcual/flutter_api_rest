// Clase que representa una respuesta HTTP
class HttpResponse<T> {
  final T? data; // Datos de la respuesta
  final HttpError? error; // Error de la respuesta

  // Constructor de la clase HttpResponse
  HttpResponse(this.data, this.error);

  // Método estático para crear una respuesta exitosa
  static HttpResponse<T> success<T>(T data) => HttpResponse(data, null);

  // Método estático para crear una respuesta fallida
  static HttpResponse<T> fail<T>({
    required int statusCode,
    required String message,
    required dynamic data
  }) => HttpResponse(null, HttpError(
    statusCode: statusCode,
    message: message,
    data: data
  ));
}

// Clase que representa un error HTTP
class HttpError {
  final int statusCode; // Código de estado del error
  final String message; // Mensaje del error
  final dynamic data; // Datos adicionales del error

  // Constructor de la clase HttpError
  HttpError({
    required this.statusCode,
    required this.message,
    required this.data
  });
}
