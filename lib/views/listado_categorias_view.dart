import 'package:ezahora/components/lista_categoria_component.dart';
import 'package:ezahora/constants/colors.dart';
import 'package:ezahora/controllers/get_data_controller_negocios.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListadoCategoriasView extends StatefulWidget {
  final int pos;

  const ListadoCategoriasView({ 
    Key? key,
    required this.pos
  }) : super(key: key);

  @override
  _ListadoCategoriasViewState createState() => _ListadoCategoriasViewState();
}

class _ListadoCategoriasViewState extends State<ListadoCategoriasView> {
  
  final getDataControllerN = Get.put(GetDataControllerNegocios());


  double h = 0;
  double w = 0;


  Map<int, String> lista = {
    1: 'Atractivos Turísticos',
    2: 'Tierra de la Cerámica',
    3: 'Mercados y Tianguis',
    4: 'Fiestas Tradicionales y Festivales',
    5: 'Carnaval',
    6: 'Ecoturismo',
    7: 'Hospedaje',
    8: 'Restaurantes y Bares',
    9: 'Gatronomía Ancestral',
  };

  Map<int, String> listaNegocios2= {
    1: 'Cerámica Mi Recuerdo',
    2: 'Corte de Madera',
  };

  Map<int, String> listaNegocios8= {
    1: 'Chelodromo',
  };


  @override
  void initState() {
    super.initState();
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
          return DefaultTabController(
            length: lista.length,
            initialIndex: widget.pos -1,
            animationDuration: const Duration(milliseconds: 300),
            child: Scaffold(
              backgroundColor: Colors.grey[200],
              body: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  appBarEZ(),
                  SliverFillRemaining(
                    child: SizedBox(
                      height: h,
                      child: !getDataControllerN.isLoading.value ? TabBarView(
                        children: [
                          ListaCategoriaComponent(
                            contador: getDataControllerN.getDataModelNegociosCat1.value.negocios.length, 
                            categoria: 1,
                            listaNegocios: getDataControllerN.getDataModelNegociosCat1.value.negocios,
                          ),
                          ListaCategoriaComponent(
                            contador: getDataControllerN.getDataModelNegociosCat2.value.negocios.length,
                            categoria: 2,
                            listaNegocios: getDataControllerN.getDataModelNegociosCat2.value.negocios,
                          ),
                          ListaCategoriaComponent(
                            contador: getDataControllerN.getDataModelNegociosCat3.value.negocios.length,
                            categoria: 3,
                            listaNegocios: getDataControllerN.getDataModelNegociosCat3.value.negocios,
                          ),
                          ListaCategoriaComponent(
                            contador: getDataControllerN.getDataModelNegociosCat4.value.negocios.length,
                            categoria: 4,
                            listaNegocios: getDataControllerN.getDataModelNegociosCat4.value.negocios,
                          ),
                          ListaCategoriaComponent(
                            contador: getDataControllerN.getDataModelNegociosCat5.value.negocios.length,
                            categoria: 5,
                            listaNegocios: getDataControllerN.getDataModelNegociosCat5.value.negocios,
                          ),
                          ListaCategoriaComponent(
                            contador: getDataControllerN.getDataModelNegociosCat6.value.negocios.length,
                            categoria: 6,
                            listaNegocios: getDataControllerN.getDataModelNegociosCat6.value.negocios,
                          ),
                          ListaCategoriaComponent(
                            contador: getDataControllerN.getDataModelNegociosCat7.value.negocios.length,
                            categoria: 7,
                            listaNegocios: getDataControllerN.getDataModelNegociosCat7.value.negocios,
                          ),
                          ListaCategoriaComponent(
                            contador: getDataControllerN.getDataModelNegociosCat8.value.negocios.length,
                            categoria: 8,
                            listaNegocios: getDataControllerN.getDataModelNegociosCat8.value.negocios,
                          ),
                          ListaCategoriaComponent(
                            contador: getDataControllerN.getDataModelNegociosCat9.value.negocios.length,
                            categoria: 9,
                            listaNegocios: getDataControllerN.getDataModelNegociosCat9.value.negocios,
                          ),
                        ],
                      ) : const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
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

  // Widgets del appbar EZ
  // appBarEZ1(){
  //   return SliverAppBar(
  //     elevation: 0,
  //     title: tituloAppBar(),
  //     titleSpacing: 0,
  //     // centerTitle: true,
  //     iconTheme: IconThemeData(
  //       size: 35,
  //       color: Palette.ezblue
  //     ),
  //     // pinned: true,
  //     floating: true,
  //     snap: false,
  //     backgroundColor: Colors.white,
  //     bottom: PreferredSize(
  //       preferredSize: const Size.fromHeight(140),
  //       child: listaCategoriaAppBar(),
  //     )
  //     // separator between appbar and body
  //   );
  // }

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

  // listaCategoriaAppBar(){
  //   return Container(
  //     height: 124,
  //     width: w,
  //     color: Colors.white,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: 9,
  //       itemBuilder: (context, index) {
  //         index++;
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
  //           child: InkWell(
  //             onTap: () {
  //               print(index);
  //             },
  //             child: SizedBox(
  //               width: 80,
  //               child: Column(
  //                 children: [
  //                   imagenesCategoria(index: index),
  //                   SizedBox(height: 15,),
  //                   textoCategoria(index: index)
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     )
  //   );
  // }

  listaCategoriaAppBar(){
    return TabBar(
      isScrollable: true,
      indicatorColor: Palette.ezBlueLight,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4,
      tabs: [
        for (var i = 1; i <= lista.length; i++) 
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
      'assets/images/$index.png', // 'assets/images/logo.png
      width: 80,
      height: 60,
      // fit: BoxFit.contain,
    );
  }

  textoCategoria({required int index}){
    return Text(
      lista[index]!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Palette.ezblue,
        fontSize: 9,
        fontWeight: FontWeight.bold
      ),
    );
  }



  // cuerpo del custom scroll view

}