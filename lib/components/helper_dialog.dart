import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogsHelp{
  static void chargingLoading({String? nombre}){
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 130.0,
            width: 20.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10.0,),
                Text(nombre ?? 'Cargando...'),
              ],
            ),
          ),
        )
      )
    );
  }

  static void alertDialog({String? title, String? content, Function? onPressed, int? opcion,IconData? icon} ){
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Text(title ?? 'Alerta'),
            SizedBox(width: 10.0,),
            Icon(
              icon ?? Icons.warning, 
              color: 
              opcion == 1 ? Colors.red : 
              opcion == 2 ? Colors.orange : Colors.green,
              size: 40,
            )
          ],
        ),
        content: SingleChildScrollView(child: Text(content ?? 'Contenido')),
        actions: [
          TextButton(
            onPressed: (){
              Get.back();
              FocusScope.of(Get.context!).unfocus(); // en caso de que el teclado este abierto lo cierra
            },
            child: Text('Aceptar')
          )
        ],
      )
    );
  }

  static void confirmDialog({String? title, String? content, Function? onPressed} ){
    Get.dialog(
      AlertDialog(
        title: Text(title ?? 'Alerta'),
        content: Text(content ?? 'Contenido'),
        actions: [
          TextButton(
            onPressed: (){
              Get.back();
            },
            child: Text('Cancelar')
          ),
          TextButton(
            onPressed: (){
              if(onPressed != null){
                onPressed();
              }
              Get.back();
            },
            child: Text('Aceptar'),
          )
        ],
      )
    );
  }

  static void closeDialog(){
    if(Get.isDialogOpen!){
      Get.back();
    }
  }
}