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
  bool disappear = false;


  // creamos los controladores de los videos
  late final VideoPlayerController _controller1 = 
    // le damos la ruta del video
    VideoPlayerController.asset('assets/images/menu/INTRO_3_DE_MAYO.mp4')

    // le decimos que se repita el video
  ..setLooping(true)

  // le decimos que se inicialice el video
  ..initialize()
  // cuando sea inicializado, se ejecutara el siguiente codigo
  .then((_) {
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

  // lista de las categorias
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

  // links de las redes sociales
  String facebook = 'https://www.facebook.com/AyuntamientoEZ?mibextid=ZbWKwL';
  String instagram = 'https://www.instagram.com/ayuntamientoemilianozapata/?igshid=NzZhOTFlYzFmZQ%3D%3D';
  String tikTok = 'https://tiktok.com/@emilianozapatamorelos?_t=8g4plQyblNV&_r=1';

  String urlAvisoPrivacidad = 'https://ezahora.com/avisoPrivacidad.html';


  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
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
      floatingActionButton: floatingPausedPlayButton(),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [

          // appbar EZ
          appBarEZ(),

          // aqui va el contenido del carrusel
          cuerpoCarrusel(),
        
          // aqui va el contenido de los antecedentes historicos
          antecedentesHistoricos(),

          // aqui va el contenido del footer
          footer(),
        ],
      ),
    );
  }

  // boton para detener el video en el carrusel
  floatingPausedPlayButton(){
    return FloatingActionButton(
      onPressed: () {
        setState(() {

          // verificamos en que posicion esta el carrousel
          if(pageController.page == 0){

            // verificamos si el video esta inicializado
            if(_controller1.value.isInitialized){

              // verificamos si el video esta reproduciendose
              if(_controller1.value.isPlaying){

                // si esta reproduciendose, lo pausamos
                _controller1.pause();

                // con esto cambiamos el icono del boton
                disable = true;
              }else{

                // si no esta reproduciendose, lo reproducimos
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
    );
  }


  // Widgets del appbar EZ
  appBarEZ(){
    return SliverAppBar(

      // le damos una elevacion de 0 para que no tenga sombra
      elevation: 0,
      title: Row(
        children: [
          // logo EZ
          logoEZAppBar(),

          // titulo EZ
          tituloAppBar(),
        ],
      ),

      // lo dejamos fijo para que al hacer scroll no se mueva
      pinned: true,
      snap: false,

      // le damos un color de fondo blanco
      backgroundColor: Colors.white,

      // le damos un tamaño al appbar
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
        'EZAhora',
        style: TextStyle(
          color: Palette.ezblue,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  listaCategoriaAppBar(){
    
    // le damos un tamaño al appbar
    return Container(
      height: 124,
      width: w,
      color: Colors.white,

      // creamos un listview.builder horizontal para mostrar las categorias con sus imagenes
      child: ListView.builder(

        // le damos un scroll horizontal
        scrollDirection: Axis.horizontal,

        // le damos cuantos items va a tener o construira el listview
        itemCount: lista.length,

        // construimos el item
        itemBuilder: (context, index) {

          // dejamos el index en 1 para que jale las imagenes correctamente
          index++;

          // damos un pading o separacion entre el item y la pared, y entre cada item
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),

            // creamos un InkWell para que al dar click en el item nos lleve a la pagina de la categoria
            child: InkWell(
              onTap: () async {

                setState(() {
                  if(_controller1.value.isPlaying){
                    _controller1.pause();
                  }
                    
                  if(_controller2.value.isPlaying){
                    _controller2.pause();
                  }

                  if(_controller3.value.isPlaying){
                    _controller3.pause();
                  }

                  disappear = true;
                });

                // al dar click en el item, nos lleva a la pagina de la categoria con el index de la categoria
                final data = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  ListadoCategoriasView(
                      pos: index,
                    ) 
                  )
                );

                disappear = data;
                setState(() {});
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

    // generamos la imagen de la categoria a traves del index
    return Image.asset(
      'assets/images/$index.png',
      width: 80,
      height: 60,
      fit: BoxFit.contain,
    );
  }

  textoCategoria({required int index}){

    // generamos el texto de la categoria a traves del index
    return Text(

      // le damos el texto a traves del index
      lista[index]!,
      textAlign: TextAlign.center,

      // le damos un estilo al texto
      style: TextStyle(
        color: Palette.ezblue,
        fontSize: 9,
        fontWeight: FontWeight.bold
      ),
    );
  }


  // carrousel de videos
  cuerpoCarrusel(){
    // le damos un tamaño al carrusel
    return SliverToBoxAdapter(
      child: Container(
        height: 400,
        width: w,
        color: Colors.purpleAccent,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [

              // creamos un pageview para mostrar los videos
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: carruselVideos(),
              ),
              
              // creamos un indicador de posicion para saber en que pagina esta el usuario
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                height: 50,
                child: indicadorPosicion(),
              )
            ],
          ),
        ),
      ),

    );
  }

  carruselVideos(){
    // creamos un pageview para mostrar los videos
    return PageView(
      // le damos el controlador del pageview para que sepa en que pagina esta
      controller: pageController,
      children: [
        if(!disappear)
          // le damos un video player al pageview
          if(_controller1.value.isInitialized)
            VideoPlayer(
              _controller1,
            )
          else
            const SizedBox()
        else
          const SizedBox(),

        if(!disappear)
        // le damos un video player al pageview
          if(_controller2.value.isInitialized)
            VideoPlayer(
              _controller2,
            )
          else
            const SizedBox()
        else
          const SizedBox(),
      ],
    );
  }

  indicadorPosicion(){

    // creamos un indicador de posicion para saber en que pagina esta el usuario
    return Center(
      child: SmoothPageIndicator(

        // con el controller le decimos en que pagina esta el usuario
        controller: pageController,
        count: 2,
        effect: ExpandingDotsEffect(
          dotHeight: 10,
          dotWidth: 10,
          dotColor: Colors.white,
          activeDotColor: Palette.ezblue,
        ),

      ),
    );
  }


  // antecedentes historicos
  antecedentesHistoricos(){
    return SliverToBoxAdapter(
      child: Padding(

        // le damos un padding para separarlo del carrusel solo de arriba
        padding: const EdgeInsets.only(top: 30.0),
        child: SizedBox(
          width: w,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  tituloAntecedentes(),
                  const SizedBox(height: 20,),
                  parrafoAntecedentes(),
                  const SizedBox(height: 20,),
                  imagenToponimia(),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  tituloAntecedentes(){
    return const Text(
      'ANTECEDENTES HISTÓRICOS',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),
    );
  }

  parrafoAntecedentes(){
    return const Text(
      'El municipio mexicano de Emiliano Zapata ha experimentado una serie de cambios en su nombre a lo largo de los siglos. Originalmente, se llamaba Tzacualpan, cuyo significado es "sobre cosa tapada". En el siglo XIX, fue rebautizado como San Vicente Zacualpan en honor a los hacendados que eran propietarios de la región. Durante el siglo XX, específicamente en 1930, el gobierno mexicano promulgó una ley que prohibía los nombres relacionados con santos religiosos, lo que llevó a que el municipio cambiara su nombre a Emiliano Zapata, en honor al Caudillo del Sur.\n\nEl 19 de diciembre de 1932, bajo la dirección del gobernador constitucional de Morelos, Don Vicente Estrada Cajigal, se crearon dos nuevos municipios en la región: Atlatlahucan y Emiliano Zapata. El primer presidente municipal de Emiliano Zapata fue Apolinar Beltrán Díaz. Estos cambios de nombre reflejan la evolución histórica y política de la región, así como la influencia de figuras emblemáticas como Emiliano Zapata en la identidad local.',
      
      // justificamos el texto
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.normal
      ),
    );
  }

  imagenToponimia(){
    return Image.asset(
      'assets/images/toponimia.png',
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
  }


  footer(){
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0,),
        child: Container( 
          width: w,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 2
              )
            )
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              left: 10.0,
              top: 30.0,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  filaRedesSociales(),
                  const SizedBox(height: 30,),
                  imagenFooter(),
                  const SizedBox(height: 30,),
                  copyright(),
                  // const SizedBox(height: 10,),
                  avisoPrivacidad(
                    urlAvisoPrivacidad: urlAvisoPrivacidad,
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }

  filaRedesSociales(){
    return Row(
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
    );
  }
  // pedimos el link de la red social y la ruta imagen de la red social
  botonRedSocial({required String linkRedSocial, required String imagenRedSocial}){
    return InkWell(

      // al dar click en el boton, se pausan los videos del carrusel y se abre el link de la red social
      onTap: () async {
        _controller1.pause();
        _controller2.pause();
        _controller3.pause();
        
        // verificamos si se puede abrir el link de la red social
        if (await canLaunchUrlString(linkRedSocial)){
          // si esto es true entonces lanzamos el link de la red social
          launchUrlString(linkRedSocial);                                  
        }
      },

      // creamos la imagen de la red social
      child: Image.asset(
        imagenRedSocial,
        width: 45,
        height: 45,
        fit: BoxFit.contain,
        color: Colors.grey,
        // colorBlendMode: BlendMode.srcATop,
      ),
    );
  }

  imagenFooter(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: Image.asset(
        'assets/images/logo_ayuntamiento_sin_fondo.png',
        fit: BoxFit.contain, 
      ),
    );
  }

  copyright(){
    return const Text(
      '© 2023 Dirección de Turismo del H. Ayuntamiento de Emiliano Zapata, Morelos.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.bold
      ),
    );
  }

  avisoPrivacidad({
    required String urlAvisoPrivacidad,
  }){
    return TextButton(
      onPressed: () async {
        // al dar click en el boton, se pausan los videos del carrusel y se abre el link del aviso de privacidad
        _controller1.pause();
        _controller2.pause();
        _controller3.pause();

        // verificamos si se puede abrir el link de la red social
        if (await canLaunchUrlString(urlAvisoPrivacidad)){
          // si esto es true entonces lanzamos el link de la red social
          launchUrlString(urlAvisoPrivacidad);                                  
        }
      },
      child: const Text(
        'Aviso de Privacidad',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          decoration: TextDecoration.underline
        ),
      ),
    );
  }

}