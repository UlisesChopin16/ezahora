import 'package:ezahora/constants/colors.dart';
import 'package:ezahora/views/listado_categorias_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({ Key? key }) : super(key: key);

  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {


  final pageController = PageController(
    initialPage: 0,
    // keepPage sirve para que no se pierda la pagina en la que se encuentra el usuario al hacer scroll en el pageview 
    // si se pone en false, cada vez que se haga scroll se va a la pagina 0
    keepPage: true,
  );

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
    return  Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          
          appBarEZ(),
    
          SliverToBoxAdapter(
            child: Container(
              height: 400,
              width: w,
              color: Colors.purpleAccent,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          Color color;
                          if(index == 0){
                            color = Palette.ezblue;
                          }else if(index == 1){
                            color = Palette.ezBlueLight;
                          }else if(index == 2){
                            
                            color = Palette.ezPink;
                          }
                          else{
                            color = Palette.ezYellow;
                          }
                          return Container(
                            color: color,
                            child: Center(
                              child: Text(
                                'Page ${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      height: 50,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 4,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            dotColor: Colors.white,
                            activeDotColor: Colors.deepOrangeAccent,
                          ),

                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                height: 290,
                width: w,
                color: Colors.greenAccent,
                child: const Center(
                  child: Text(
                    'Aquí va el contenido de la imagen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
            ),
          ),

          // aqui va el contenido del footer
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
              child: Container(
                height: 185,
                width: w,
                color: Colors.greenAccent,
                child: const Center(
                  child: Text(
                    'Aquí va el contenido del footer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  // Widgets del appbar EZ
  appBarEZ(){
    return SliverAppBar(
      elevation: 0,
      title: Row(
        children: [
          logoEZAppBar(),
          tituloAppBar(),
        ],
      ),
      pinned: true,
      snap: false,
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: listaCategoriaAppBar(),
      )
      // separator between appbar and body
    );
  }

  logoEZAppBar(){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Image.asset(
        'assets/images/logo.png',
        width: 45,
        height: 45,
        fit: BoxFit.contain,
      ),
    );
  }

  tituloAppBar(){
    return Padding( 
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Text(
        'EzAhora',
        style: TextStyle(
          color: Palette.ezblue,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  listaCategoriaAppBar(){
    return Container(
      height: 124,
      width: w,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 9,
        itemBuilder: (context, index) {
          index++;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ListadoCategoriasView(
                  pos: index,
                ) ));
              },
              child: SizedBox(
                width: 80,
                child: Column(
                  children: [
                    imagenesCategoria(index: index),
                    SizedBox(height: 15,),
                    textoCategoria(index: index)
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }

  imagenesCategoria({required int index}){
    return Image.asset(
      'assets/images/$index.png', // 'assets/images/logo.png
      width: 80,
      height: 60,
      fit: BoxFit.contain,
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