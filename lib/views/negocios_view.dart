import 'package:ezahora/constants/colors.dart';
import 'package:ezahora/views/image_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NegociosView extends StatefulWidget {

  final String nombreNegocio;
  final String direccion;
  final String linkDireccion;
  final String telefono;
  final String redSocial;
  final String descripcion;
  final String direccionImagen;

  const NegociosView({ 
    Key? key,
    required this.nombreNegocio,
    required this.direccion,
    required this.linkDireccion,
    required this.telefono,
    required this.redSocial,
    required this.descripcion,
    required this.direccionImagen,
  }) : super(key: key);

  @override
  _NegociosViewState createState() => _NegociosViewState();
}

class _NegociosViewState extends State<NegociosView> {

  final pageController = PageController(
    initialPage: 0,
    // keepPage sirve para que no se pierda la pagina en la que se encuentra el usuario al hacer scroll en el pageview 
    // si se pone en false, cada vez que se haga scroll se va a la pagina 0
    keepPage: true,
  );

  double h = 0;
  double w = 0;


  // metodo para obtener el tamaño de la pantalla
  void getScreenSize() {
    setState(() {
      w = MediaQuery.of(context).size.width;
      h = MediaQuery.of(context).size.height;
    });
  }

  // Metodo para agrandar el tamaño del titulo del negocio
  double agrandar(){
    // si el nombre del negocio es mayor a 28 caracteres, agrandamos el tamaño del titulo
    if(widget.nombreNegocio.length > 32){
      return 100;
    }else{
      return 60;
    }
  }

  // Metodo para quitar acentos de una palabra
  String quitarAcentos(String cadena) {

    // quitar acentos de las vocales en mayusculas y minusculas
    cadena = cadena.replaceAll('á', 'a');

    cadena = cadena.replaceAll('é', 'e');
    
    cadena = cadena.replaceAll('í', 'i');
    
    cadena = cadena.replaceAll('ó', 'o');
    
    cadena = cadena.replaceAll('ú', 'u');
    
    cadena = cadena.replaceAll('Á', 'A');
    
    cadena = cadena.replaceAll('É', 'E');
    
    cadena = cadena.replaceAll('Í', 'I');
    
    cadena = cadena.replaceAll('Ó', 'O');
    
    cadena = cadena.replaceAll('Ú', 'U');

    // quitar ñ y Ñ
    cadena = cadena.replaceAll('ñ', 'n');
    cadena = cadena.replaceAll('Ñ', 'N');

    // quitar comillas dobles
    cadena = cadena.replaceAll('"', '');

    // quitar comillas simples
    cadena = cadena.replaceAll("'", '');

    // quitar guiones
    cadena = cadena.replaceAll("-", '');

    // quitar parentesis
    cadena = cadena.replaceAll("(", '');
    cadena = cadena.replaceAll(")", '');

    // quitar signos de interrogacion
    cadena = cadena.replaceAll("¿", '');
    cadena = cadena.replaceAll("?", '');

    // quitar signos de exclamacion
    cadena = cadena.replaceAll("¡", '');
    cadena = cadena.replaceAll("!", '');

    // quitar slash
    cadena = cadena.replaceAll("/", '');

    // quitar asterisco
    cadena = cadena.replaceAll("*", '');

    // quitar diéresis de todas las vocales
    cadena = cadena.replaceAll("ü", 'u');

    cadena = cadena.replaceAll("Ü", 'U');

    cadena = cadena.replaceAll("ï", 'i');

    cadena = cadena.replaceAll("Ï", 'I');

    cadena = cadena.replaceAll("ë", 'e');

    cadena = cadena.replaceAll("Ë", 'E');

    cadena = cadena.replaceAll("ö", 'o');

    cadena = cadena.replaceAll("Ö", 'O');

    cadena = cadena.replaceAll("ä", 'a');
    
    cadena = cadena.replaceAll("Ä", 'A');

    // regresar la cadena sin ningun caracter especial
    return cadena;
  }


  @override
  Widget build(BuildContext context) {
    getScreenSize();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Appbar con el nombre del negocio
          appBarNegocio(),

          // Informacion del negocio
          informacionNegocio(),
        ],
      ),
    );
  }

  appBarNegocio(){
    return SliverAppBar(

      // le damos un tamaño al appbar
      expandedHeight: 300,

      // lo ponemos fijo en la parte superior
      pinned: true,
      backgroundColor: Colors.white,

      // le damos una sombra
      elevation: 4,
      leading: botonRegreso(),

      // le damos un efecto de blur al appbar al hacer scroll
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: carruselImagenesNegocio(),
            ),
            Positioned(
              // posicionamos el indicador de paginas en la parte inferior
              bottom: agrandar() + 5,
              left: 0,
              right: 0,
              child: indicadorImagenNegocio(),
            ),
          ],
        ),

        // le damos un efecto de blur al appbar al hacer scroll
        stretchModes: [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(agrandar()),
        child: contenedorParaTitulo()
      ),
    );
  }

  botonRegreso(){
    return IconButton(
      onPressed: () {
        // regresar a la pantalla anterior
        Navigator.pop(context);
      },
      icon: Container(
        // le ponemos un color de fondo para que se vea el circulo
        decoration: const BoxDecoration(
          color: Colors.white,

          // le damos forma de circulo
          shape: BoxShape.circle
        ),

        // elegimos el icono, le damos tamaño y color
        child: Icon(
          Icons.arrow_back_rounded,
          color: Palette.ezPink,
          size: 35,
        )
      ),

    );
  }

  carruselImagenesNegocio(){
    return PageView.builder(
      controller: pageController,
      itemCount: 5,
      itemBuilder: (context, index) {

        // ruta de la imagen
        String rutaImagen = '${widget.direccionImagen}${quitarAcentos(widget.nombreNegocio)}/${quitarAcentos(widget.nombreNegocio)}';
        
        // aumentamos el index para que empiece en 1
        index++;
        return InkWell(
          onTap: () {
            // ir a la pantalla de la imagen para que se vean más grandes
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ImageView(
                  // mandamos la ruta de la imagen, el nombre del negocio y la posicion de la imagen
                  imageUrl: rutaImagen,
                  title: widget.nombreNegocio,
                  index: (index - 1),
                ),
              ),
            );
          },

          // imagen que se muestra en el carrusel
          child: Container(
            width: 100,
            height: 100,
            color: Colors.grey,
            child: Image.network(
              '$rutaImagen$index.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                      colorBlendMode: BlendMode.color,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'Imagen no disponible',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7)
                      )
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  indicadorImagenNegocio(){
    return Center(
      child: SmoothPageIndicator(
        controller: pageController,
        // numero de imagenes que se van a mostrar
        count: 5,
        effect: ExpandingDotsEffect(
          dotHeight: 10,
          dotWidth: 10,
          dotColor: Colors.white,
          activeDotColor: Palette.ezPink
        ),
    
      ),
    );
  }

  contenedorParaTitulo(){
    return Container(
      height: agrandar(),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            widget.nombreNegocio,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }


  informacionNegocio(){
    return SliverList(
      delegate: SliverChildListDelegate(
        [ 
          // Dirección
          const SizedBox(height: 10,),
          iconoTextoDireccion(),
          const SizedBox(height: 10,),


          // telefono
          iconoTextoTelefono(),
          const SizedBox(height: 10,),


          // red social
          if(widget.redSocial != 'No cuenta con redes sociales')
            iconoTextoRedSocial()
          else 
            const SizedBox(height: 10,),
          const SizedBox(height: 10,),


          // descripcion
          textoResena(),
          const SizedBox(height: 10,),


          // mapa
          mapaBotonNegocio(),
        ],
      )
    );
  }


  iconoTextoDireccion(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconoDireccion(),
          SizedBox(width: 10,),
          textoLinkDireccion(),
        ],
      ),
    );
  }

  iconoDireccion(){
    return Icon(
      Icons.location_on,
      color: Palette.ezPink,
      size: 20,
    );
  }

  textoLinkDireccion(){
    return Expanded(
      child: TextButton(
        onPressed: ()async{
          // Abrir el url con el linkRedSocial
          if (await canLaunchUrlString(widget.linkDireccion)){
            
            launchUrlString(widget.linkDireccion);                                  
          }
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.direccion,
            style: TextStyle(
              color: Palette.ezPink,
              fontSize: 11,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }


  iconoTextoTelefono(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconoTelefono(),
          SizedBox(width: 18,),
          numeroTelefono(),
        ],
      ),
    );
  }

  iconoTelefono(){
    return Icon(
      Icons.phone,
      color: Palette.ezPink,
      size: 20,
    );
  }

  numeroTelefono(){
    return Expanded(
      child: Text(
        widget.telefono,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 11,
        ),
      ),
    );
  }


  iconoTextoRedSocial(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconoRedSocial(),
          SizedBox(width: 10,),
          textoLinkRedSocial(),
        ],
      ),
    );
  }

  iconoRedSocial(){
    return Icon(
      Icons.facebook,
      color: Palette.ezPink,
      size: 20,
    );
  }

  textoLinkRedSocial(){
    return Expanded(
      child: TextButton(
        onPressed: ()async{
          // Abrir el url con el linkRedSocial
          if (await canLaunchUrlString(widget.redSocial)){
            launchUrlString(widget.redSocial);                                  
          }
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.redSocial,
            style: TextStyle(
              color: Palette.ezPink,
              fontSize: 11,
              fontWeight: FontWeight.bold
            )
          ),
        ),
      ),
    );
  }


  textoResena(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        widget.descripcion,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }


  mapaBotonNegocio(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () async{
          // Abrir el url con el linkRedSocial
          if (await canLaunchUrlString(widget.linkDireccion)){
            launchUrlString(widget.linkDireccion);                                  
          }
        },
        child: Image.network(
          '${widget.direccionImagen}${quitarAcentos(widget.nombreNegocio)}/Mapa ${quitarAcentos(widget.nombreNegocio)}.png',
          width: w,
          height: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
} 