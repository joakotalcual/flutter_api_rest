// Importación de bibliotecas
import 'package:flutter/cupertino.dart'; // Importa definiciones específicas de Cupertino para widgets y temas
import 'package:flutter/material.dart'; // Importa definiciones específicas de Material Design para widgets y temas

// Clase abstracta para manejar diálogos
abstract class Dialogs {

  // Método estático para mostrar un diálogo de alerta
  static alert(
      BuildContext context,
      {required String title,
      required String description}) {
    // Muestra un diálogo de alerta con título, descripción y un botón "OK"
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pop(_);
            },
            child: const Text('OK')
        )
      ],
    ));
  }

}

// Clase abstracta para manejar diálogos de progreso
abstract class ProgressDialog {

  // Método estático para mostrar un diálogo de progreso
  static show(BuildContext context) {
    // Muestra un diálogo modal de progreso de Cupertino
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) {
                // Acciones que se realizan al intentar cerrar el diálogo
                return;
              }
              // Acciones que se realizan al intentar retroceder
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(0.9),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
    );
  }

  // Método estático para cerrar el diálogo de progreso
  static dismiss(BuildContext context) {
    Navigator.pop(context); // Cierra el diálogo de progreso
  }

}
