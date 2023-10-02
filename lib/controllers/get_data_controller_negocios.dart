import 'package:ezahora/models/negocios_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetDataControllerNegocios extends GetxController{
  
  var isLoading = false.obs;
  var error = false.obs;

  // lista de negocios por categoria
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


  // metodo para obtener la ruta de la api
  rutaURL(String ruta) => 
    Uri.parse('https://ezahora.com/EZAhora/$ruta.php');

  // metodo para obtener los datos de la api
  getDataNegocios() async {

    error.value = false;
    // dejamos el valor de isLoading en true para mostrar el loading
    isLoading.value = true;

    try{
      // hacemos la peticion a la api
      var response = await http.post(

        // nombre de la api
        rutaURL('empresas'),
      );

      // limpiamos las listas
      getDataModelNegocios.value.negocios.clear();
      getDataModelNegociosCat1.value.negocios.clear();
      getDataModelNegociosCat2.value.negocios.clear();
      getDataModelNegociosCat4.value.negocios.clear();
      getDataModelNegociosCat7.value.negocios.clear();
      getDataModelNegociosCat8.value.negocios.clear();

      // agregamos los datos a la lista
      getDataModelNegocios.value = getDataModelNegociosFromJson(response.body);

      // dejamos el valor de isLoading en false para ocultar el loading
      isLoading.value = false;

      // recorremos la lista de negocios para separarlos por categoria
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
      // dejamos el valor de isLoading en false para ocultar el loading
      isLoading.value = false;
      error.value = true;
      // mostramos el error
      // print(e);
    }
  }

}