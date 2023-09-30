import 'package:ezahora/components/lista_categoria_component.dart';
import 'package:ezahora/components/lista_categoria_solo_imagen_component.dart';
import 'package:ezahora/constants/colors.dart';
import 'package:ezahora/controllers/get_data_controller_negocios.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListadoCategoriasView extends StatefulWidget {
  
  // obtener el index de la categoria seleccionada 
  final int pos;

  const ListadoCategoriasView({ 
    Key? key,
    required this.pos
  }) : super(key: key);

  @override
  _ListadoCategoriasViewState createState() => _ListadoCategoriasViewState();
}

class _ListadoCategoriasViewState extends State<ListadoCategoriasView> {
  
  // instancia del controlador de datos
  final getDataControllerN = Get.put(GetDataControllerNegocios());


  double h = 0;
  double w = 0;

  // reseña1
  String tituloResena1 = 'Explorando los Tesoros del Mercado en el Corazón del Pueblo';
  String resena1 = 'El mercado municipal de Emiliano Zapata se encuentra ubicado en el corazón del pueblo, está establecido dentro de la ex hacienda San Vicente Zacualpan, está en funcionamiento desde hace más de 48 años. En el mercado podrás encontrar una gran variedad de productos como: carne roja y blanca, así como frutas y verduras de gran calidad. El mercado es ideal para adquirir toda la canasta básica a muy buenos precios.';

  // reseña2
  String tituloResena2 = 'Deslumbrantes Carnavales: Alegría, Color y Tradición';
  String resena2 = 'El Carnaval de Emiliano Zapata año con año tiene para ti un espectacular programa de actividades y entretenimiento para toda la familia, dentro del marco del Carnaval Emiliano Zapata podrás disfrutar de:\n\n'
  +'•	Quema de castillo\n' +
  '•	Show de las viudas\n'+
  '•	Tradicional Brinco del Chinelo\n'+
  '•	Jaripeo.\n'+
  'Sin duda, una gran experiencia a los que pueden visitar el lugar en estas fechas';

  // reseña3 
  String tituloResena3 = 'Sabores que despiertan emociones: un viaje de sabores irresistibles';
  String resena3 = 'En Emiliano Zapata los antojitos mexicanos son un verdadero tesoro culinario que nos transporta a las raíces auténticas de la gastronomía mexicana. En cada esquina, se encuentran pequeños puestos y restaurantes que ofrecen una amplia variedad de platillos que deleitan los paladares locales y visitantes por igual.\n\n'+
  'Los tacos, quesadillas, pancita, barbacoa, elotes, esquites, tostadas y, por supuesto el pozole son algunos de aquellos antojitos mexicanos que se encuentran presentes en nuestra localidad y son una verdadera expresión de la cultura y la tradición culinaria de México. Cada bocado es una experiencia que despierta los sentidos y hace honor a una de las cocinas más ricas y variadas del mundo.';

  @override
  void initState() {
    super.initState();
    // obtener los datos de los negocios al entrar a la pagina
    getDataControllerN.getDataNegocios();
  }

  // metodo para obtener el tamaño de la pantalla
  void getScreenSize() {
    setState(() {
      w = MediaQuery.of(context).size.width;
      h = MediaQuery.of(context).size.height;
    });
  }


  @override
  Widget build(BuildContext context) {
    getScreenSize();
    return Obx( () {
        // hacer un if para que no se muestre nada hasta que se obtengan los datos
        return DefaultTabController(
          length: getDataControllerN.lista.length,
          initialIndex: widget.pos -1,
          animationDuration: const Duration(milliseconds: 300),
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                appBarEZ(),
                cuerpoListado(),
              ]
            ),
          ),
        );
      }
    );
  }


  // Widgets del appbar EZ
  appBarEZ(){
    return SliverAppBar(
      elevation: 4,
      title: tituloAppBar(),
      titleSpacing: 0,
      // centerTitle: true,
      iconTheme: IconThemeData(
        size: 35,
        color: Palette.ezblue
      ),
      pinned: true,
      // floating: false,
      snap: false,
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: listaCategoriaAppBar(),
      )
      // separator between appbar and body
    );
  }


  tituloAppBar(){
    return Text(
      'Descubre',
      style: TextStyle(
        color: Palette.ezblue,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
    );
  }

  listaCategoriaAppBar(){
    return TabBar(
      isScrollable: true,
      indicatorColor: Palette.ezBlueLight,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4,
      tabs: [
        // hacer un for para crear las tabs a partir del largo de la lista
        for (var i = 1; i <= getDataControllerN.lista.length; i++) 
          Tab(
            height: 120,
            child: Column(
              children: [
                imagenesCategoria(index: i),
                SizedBox(height: 15,),
                SizedBox(
                  width: 80,
                  child: textoCategoria(
                    index: i
                  )
                )
              ],
            ),
          )
      ],
    );
  }

  imagenesCategoria({required int index}){
    return Image.asset(
      'assets/images/$index.png',
      width: 80,
      height: 60,
      // fit: BoxFit.contain,
    );
  }

  textoCategoria({required int index}){
    return Text(
      getDataControllerN.lista[index]!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Palette.ezblue,
        fontSize: 9,
        fontWeight: FontWeight.bold
      ),
    );
  }


  cuerpoListado(){
    return SliverFillRemaining(
      child: SizedBox(
        height: h,
        child: !getDataControllerN.isLoading.value ? vistaListadoCategoria() 
          : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  vistaListadoCategoria(){
    return TabBarView(
      children: [
        ListaCategoriaComponent(
          contador: getDataControllerN.getDataModelNegociosCat1.value.negocios.length, 
          listaNegocios: getDataControllerN.getDataModelNegociosCat1.value.negocios,
        ),
        ListaCategoriaComponent(
          contador: getDataControllerN.getDataModelNegociosCat2.value.negocios.length,
          listaNegocios: getDataControllerN.getDataModelNegociosCat2.value.negocios,
        ),
        ListaCategoriaImagenComponent(
          contador: 4,
          categoria: 3,
          tituloResena: tituloResena1,
          resena: resena1,
        ),
        ListaCategoriaComponent(
          contador: getDataControllerN.getDataModelNegociosCat4.value.negocios.length,
          listaNegocios: getDataControllerN.getDataModelNegociosCat4.value.negocios,
        ),
        ListaCategoriaImagenComponent(
          contador: 4,
          categoria: 5,
          tituloResena: tituloResena2,
          resena: resena2,
        ),
        ListaCategoriaComponent(
          contador: getDataControllerN.getDataModelNegociosCat7.value.negocios.length,
          listaNegocios: getDataControllerN.getDataModelNegociosCat7.value.negocios,
        ),
        ListaCategoriaComponent(
          contador: getDataControllerN.getDataModelNegociosCat8.value.negocios.length,
          listaNegocios: getDataControllerN.getDataModelNegociosCat8.value.negocios,
        ),
        ListaCategoriaImagenComponent(
          contador: 4,
          categoria: 9,
          tituloResena: tituloResena3,
          resena: resena3,
        ),
      ],
    );
  }

}