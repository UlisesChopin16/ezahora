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
  var getDataModelNegociosCat4 = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat7 = GetDataModelNegocios(negocios: []).obs;
  var getDataModelNegociosCat8 = GetDataModelNegocios(negocios: []).obs;

  // lista de categorias
  var lista = {
    1: 'Atractivos Turísticos',
    2: 'Tierra de la Cerámica',
    3: 'Mercados y Tianguis',
    4: 'Fiestas Tradicionales y Festivales',
    5: 'Carnaval',
    6: 'Hospedaje',
    7: 'Restaurantes y Bares',
    8: 'Gatronomía Local',
  }.obs;

  rutaURL(String ruta) => 
    Uri.parse('https://androidexd.000webhostapp.com/loginphp/EZAhora/$ruta.php');

  

  getDataNegocios() async {
    isLoading.value = true;
    try{
      var response = await http.post(
        rutaURL('empresas'),
      );

      getDataModelNegocios.value.negocios.clear();
      getDataModelNegociosCat1.value.negocios.clear();
      getDataModelNegociosCat2.value.negocios.clear();
      getDataModelNegociosCat4.value.negocios.clear();
      getDataModelNegociosCat7.value.negocios.clear();
      getDataModelNegociosCat8.value.negocios.clear();
      
      getDataModelNegocios.value = getDataModelNegociosFromJson(response.body);
      isLoading.value = false;

      for(int i = 0; i < getDataModelNegocios.value.negocios.length; i++){
        if(getDataModelNegocios.value.negocios[i].idCategoria == '1'){
          getDataModelNegociosCat1.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '2'){
          getDataModelNegociosCat2.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '4'){
          getDataModelNegociosCat4.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '7'){
          getDataModelNegociosCat7.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }else if(getDataModelNegocios.value.negocios[i].idCategoria == '8'){
          getDataModelNegociosCat8.value.negocios.add(getDataModelNegocios.value.negocios[i]);
        }
      }
    }catch(e){
      print(e);
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