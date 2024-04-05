import 'package:logger/logger.dart';

class Logs {

  // Constructor privado para evitar instancias externas
  Logs._internal();

  // Instancia única de Logs
  static final Logs _instance = Logs._internal();

  // Instancia del logger
  final Logger _logger = Logger();

  // Getter estático para acceder al logger
  static Logger get p => _instance._logger;

}
