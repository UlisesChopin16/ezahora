import 'package:ezahora/components/helper_dialog.dart';
import 'package:ezahora/models/negocios_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetDataControllerNegocios extends GetxController{

  var searchController = TextEditingController().obs;
  
  var isLoading = false.obs;

  var getDataModelNegocios = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat1 = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat2 = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat3 = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat4 = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat5 = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat6 = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat7 = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat8 = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat9 = GetDataModelNegocios(negocios: []).obs;

  rutaURL(String ruta) => 
    Uri.parse('https://androidexd.000webhostapp.com/loginphp/EZAhora/$ruta.php');

  

  getDataNegocios() async {
    isLoading.value = true;
    try{
      var response = await http.post(
        rutaURL('empresas'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      
      getDataModelNegocios.value.negocios.clear();
      getDataModelNegociosCat1.value.negocios.clear();
      getDataModelNegociosCat2.value.negocios.clear();
      getDataModelNegociosCat3.value.negocios.clear();
      getDataModelNegociosCat4.value.negocios.clear();
      getDataModelNegociosCat5.value.negocios.clear();
      getDataModelNegociosCat6.value.negocios.clear();
      getDataModelNegociosCat7.value.negocios.clear();
      getDataModelNegociosCat8.value.negocios.clear();
      getDataModelNegociosCat9.value.negocios.clear();
      

      getDataModelNegocios.value = getDataModelNegociosFromJson(response.body);
      isLoading.value = false;

      for(int i = 0; i < getDataModelNegocios.value.negocios.length; i++){
        if(getDataModelNegocios.value.negocios[i].idCategoria == '1'){
          getDataModelNegociosCat1.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '2'){
          getDataModelNegociosCat2.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '3'){
          getDataModelNegociosCat3.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '4'){
          getDataModelNegociosCat4.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '5'){
          getDataModelNegociosCat5.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '6'){
          getDataModelNegociosCat6.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '7'){
          getDataModelNegociosCat7.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '8'){
          getDataModelNegociosCat8.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '9'){
          getDataModelNegociosCat9.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }
      }
    }catch(e){
      // Atraparemos los errores de conexión
      if(e.toString().contains('Failed host lookup')){
        showMessage(
          opcion: 1,
          title: 'Error', 
          content: 'La conexion fallo, por favor intente de nuevo mas tarde'
        );
      }
      else if(e.toString().contains('Connection failed')){
        showMessage(
          opcion: 1,
          title: 'Error', 
          content: 'La conexion fallo, por favor intente de nuevo mas tarde'
        );
      }
      // Si el error es de conexion entnces muestro un mensaje de error
      else if(e.toString().contains('SocketException')){
        showMessage(
          opcion: 1,
          title: 'Error', 
          content: 'Hubo un error de conexion, por favor intente de nuevo mas tarde'
        );
      }else{
        showMessage(
          opcion: 1,
          title: 'Error', 
          content: 'Algo salio mal, por favor intente de nuevo mas tarde'
        );
      }
    }
    
  }

  showLoading({String? nombre}) {
    DialogsHelp.chargingLoading(nombre: nombre);
  }

  showMessage({String? title, String? content, int? opcion,IconData? icon}) {
    DialogsHelp.alertDialog(
      title: title, 
      content: content, 
      opcion: opcion, 
      icon: icon,
    );
  }

  hideLoading() {
    DialogsHelp.closeDialog();
  }

}