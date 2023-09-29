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

  // comando para generar el apk 
  // flutter build apk --split-per-abi

  void getScreenSize() {
    setState(() {
      w = MediaQuery.of(context).size.width;
      h = MediaQuery.of(context).size.height;
    });
  }

  double agrandar(){
    if(widget.nombreNegocio.length > 28){
      return 100;
    }else{
      return 60;
    }
  }

  // Metodo para quitar acentos de una palabra
  String quitarAcentos(String cadena) {
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
    cadena = cadena.replaceAll('ñ', 'n');
    cadena = cadena.replaceAll('Ñ', 'N');

    // quitar comillas dobles
    cadena = cadena.replaceAll('"', '');

    // quitar comillas simples
    cadena = cadena.replaceAll("'", '');

    cadena = cadena.replaceAll("*", '');

    cadena = cadena.replaceAll("¨", '');

    // quitar dierisis (diéresis) de la u y todas las vocales
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

    return cadena;
  }



  @override
  Widget build(BuildContext context) {
    getScreenSize();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // collapsedHeight: 200,
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 4,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Palette.ezPink,
                  size: 35,
                )
              ),

            ),
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        String rutaImagen = '${widget.direccionImagen}${quitarAcentos(widget.nombreNegocio)}/${quitarAcentos(widget.nombreNegocio)}';
                        index++;
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageView(
                                  imageUrl: rutaImagen,
                                  title: widget.nombreNegocio,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            '$rutaImagen$index.jpg',
                            fit: BoxFit.cover,
                            //  como se muestra la imagen después de que haya terminado de cargar?
                                          
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: agrandar() + 5,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 5,
                        effect: ExpandingDotsEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          dotColor: Colors.white,
                          activeDotColor: Palette.ezPink
                        ),
                    
                      ),
                    ),
                  ),
                ],
              ),
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(agrandar()),
              child: Container(
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
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              [
                
                // Dirección
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Palette.ezPink,
                        size: 20,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                // telefono
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Palette.ezPink,
                        size: 20,
                      ),
                      SizedBox(width: 18,),
                      Expanded(
                        child: Text(
                          widget.telefono,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                // red social
                if(widget.redSocial != 'No cuenta con redes sociales')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Palette.ezPink,
                          size: 20,
                        ),
                        SizedBox(width: 10,),
                        Expanded(
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
                        ),
                      ],
                    ),
                  )
                else 
                  const SizedBox(height: 10,),
                const SizedBox(height: 10,),
                // descripcion
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.descripcion,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                // mapa
                Padding(
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
                )
              ],
            )
          )
        ],
      ),
    );
  }
}