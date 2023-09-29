import 'package:ezahora/constants/colors.dart';
import 'package:ezahora/views/listado_categorias_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({ Key? key }) : super(key: key);

  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {

  bool disable = false;

  late final VideoPlayerController _controller1 = VideoPlayerController.asset('assets/images/menu/INTRO_3_DE_MAYO.mp4')
  ..setLooping(true)
  ..initialize().then((_) {
    setState(() {
      // Si pageController esta en el index 0, se reproduce el video
      _controller1.play(); 
    });
  });


  late final VideoPlayerController _controller2 = VideoPlayerController.asset('assets/images/menu/IGLESIA_TEZOYUCA_DRONE.mp4')
  ..setLooping(true)
  ..initialize();

  late final VideoPlayerController _controller3 = VideoPlayerController.asset('assets/images/menu/IGLESIA_TEPETZINGO_DRONE.mp4')
  ..setLooping(true)
  ..initialize();



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
    6: 'Hospedaje',
    7: 'Restaurantes y Bares',
    8: 'Gatronomía Local',
  };

  String facebook = 'https://www.facebook.com/AyuntamientoEZ?mibextid=ZbWKwL';
  String instagram = 'https://www.instagram.com/ayuntamientoemilianozapata/?igshid=NzZhOTFlYzFmZQ%3D%3D';
  String tikTok = 'https://tiktok.com/@emilianozapatamorelos?_t=8g4plQyblNV&_r=1';


  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      if(pageController.page == 0){
        if(_controller1.value.isInitialized){
          if(_controller1.value.isPlaying){
            _controller1.pause();
            disable = true;
          }else{
            _controller1.play();
            disable = false;
          }
        }
      }else if(pageController.page == 1){
        if(_controller2.value.isInitialized){
          if(_controller2.value.isPlaying){
            _controller2.pause();
            disable = true;
          }else{
            _controller2.play();
            disable = false;
          }
        }
      }else if(pageController.page == 2){
        if(_controller3.value.isInitialized){
          if(_controller3.value.isPlaying){
            _controller3.pause();
            disable = true;
          }else{
            _controller3.play();
            disable = false;
          }
        }
      }
    });
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
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if(pageController.page == 0){
              if(_controller1.value.isInitialized){
                if(_controller1.value.isPlaying){
                  _controller1.pause();
                  disable = true;
                }else{
                  _controller1.play();
                  disable = false;
                }
              }
            }else if(pageController.page == 1){
              if(_controller2.value.isInitialized){
                if(_controller2.value.isPlaying){
                  _controller2.pause();
                  disable = true;
                }else{
                  _controller2.play();
                  disable = false;
                }
              }
            }else if(pageController.page == 2){
              if(_controller3.value.isInitialized){
                if(_controller3.value.isPlaying){
                  _controller3.pause();
                  disable = true;
                }else{
                  _controller3.play();
                  disable = false;
                }
              }
            }
          });
        },
        child: disable ? Icon(Icons.play_arrow) : Icon(Icons.pause),
        backgroundColor: Palette.ezblue,
      ),
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
                      child: PageView(
                        controller: pageController,
                        children: [
                          VideoPlayer(
                            _controller1,
                          ),
                          VideoPlayer(
                            _controller2,
                          ),
                        ],
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
                          count: 2,
                          effect: ExpandingDotsEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            dotColor: Colors.white,
                            activeDotColor: Palette.ezblue,
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
              child: SizedBox(
                width: w,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'ANTECEDENTES HISTÓRICOS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'El municipio mexicano de Emiliano Zapata ha experimentado una serie de cambios en su nombre a lo largo de los siglos. Originalmente, se llamaba Tzacualpan, cuyo significado es "sobre cosa tapada". En el siglo XIX, fue rebautizado como San Vicente Zacualpan en honor a los hacendados que eran propietarios de la región. Durante el siglo XX, específicamente en 1930, el gobierno mexicano promulgó una ley que prohibía los nombres relacionados con santos religiosos, lo que llevó a que el municipio cambiara su nombre a Emiliano Zapata, en honor al Caudillo del Sur.\n\nEl 19 de diciembre de 1932, bajo la dirección del gobernador constitucional de Morelos, Don Vicente Estrada Cajigal, se crearon dos nuevos municipios en la región: Atlatlahucan y Emiliano Zapata. El primer presidente municipal de Emiliano Zapata fue Apolinar Beltrán Díaz. Estos cambios de nombre reflejan la evolución histórica y política de la región, así como la influencia de figuras emblemáticas como Emiliano Zapata en la identidad local.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
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
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 2
                    )
                  )
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // facebook
                      botonRedSocial(
                        linkRedSocial: facebook, 
                        imagenRedSocial: 'assets/images/menu/facebook.png'
                      ),

                      SizedBox(width: 25,),

                      // instagram
                      botonRedSocial(
                        linkRedSocial: instagram, 
                        imagenRedSocial: 'assets/images/menu/instagram.png'
                      ),

                      SizedBox(width: 25,),

                      // tiktok
                      botonRedSocial(
                        linkRedSocial: tikTok, 
                        imagenRedSocial: 'assets/images/menu/tiktok.png'
                      ),

                    ],
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
        itemCount: lista.length,
        itemBuilder: (context, index) {
          index++;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ListadoCategoriasView(
                  pos: index,
                ) ));
                _controller1.pause();
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

  botonRedSocial({required String linkRedSocial, required String imagenRedSocial}){
    return InkWell(
      onTap: () async {
        _controller1.pause();
        _controller2.pause();
        _controller3.pause();
        // Abrir el url con el linkRedSocial
        if (await canLaunchUrlString(linkRedSocial)){
          launchUrlString(linkRedSocial);                                  
        }
      },
      child: Image.asset(
        imagenRedSocial,
        width: 45,
        height: 45,
        fit: BoxFit.contain,
      ),
    );
  }



  // cuerpo del custom scroll view

}