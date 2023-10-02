import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezahora/constants/colors.dart';
import 'package:ezahora/models/negocios_model.dart';
import 'package:ezahora/views/negocios_view.dart';
import 'package:flutter/material.dart';

class ListaCategoriaComponent extends StatefulWidget {


  final int contador;

  final List<Negocios>? listaNegocios;

  final ScrollController scrollController;


  const ListaCategoriaComponent({ 
    Key? key, 

    // Aqui se reciben los parametros
    required this.contador,
    required this.scrollController,
    this.listaNegocios

  }) : super(key: key);

  @override
  _ListaCategoriaComponentState createState() => _ListaCategoriaComponentState();
}

class _ListaCategoriaComponentState extends State<ListaCategoriaComponent> {
  
  // direccion de la api donde se encuentran las imagenes
  String direccionImagen = 'https://ezahora.com/turismo/APP1/';  
  String direccionCarpetaImagen = '';


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
  Widget build(BuildContext context){
    // una vez que se obtienen los datos de la api se muestra la lista de negocios
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: widget.contador,
      itemBuilder: (context, index) {
        // obtenemos los datos de la lista de negocios
        final negocios = widget.listaNegocios![index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: InkWell(
            onTap: () {
              // ruta de las carpetas de las imagenes
              setState(() {
                if(widget.listaNegocios![index].idCategoria == '2'){
                  direccionCarpetaImagen = '${direccionImagen}CERAMICAS/';
                }else if(widget.listaNegocios![index].idCategoria == '7'){
                  direccionCarpetaImagen = '${direccionImagen}Hospedaje/';
                }else if(widget.listaNegocios![index].idCategoria == '8'){
                  direccionCarpetaImagen = '${direccionImagen}RestaurantesyBares/';
                }
              });

              // navegamos a la vista de negocios y enviamos los datos
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NegociosView(
                    nombreNegocio: negocios.nombreComercial, 
                    direccion: '${negocios.direccion}, ${negocios.colonia}, ${negocios.municipio}, ${negocios.estado}, ${negocios.codigoPostal}',
                    linkDireccion: negocios.linkDireccion!,
                    telefono: negocios.telefono!, 
                    redSocial: negocios.redesSociales!, 
                    descripcion: negocios.comentarios, 
                    direccionImagen: direccionCarpetaImagen
                  )
                )
              );

            },
            child: Card(
              elevation: 2,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 410,
                width: 200,
                child: Stack(
                  alignment: Alignment.center,
          
                  children: [
                    // Imagen principal del negocio
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: imagenesCategoria(index: index)
                    ),

                    // Nombre del negocio
                    Positioned(
                      top: 270,
                      left: 20,
                      right: 20,
                      child: Text(
                        '${widget.listaNegocios![index].nombreComercial}',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),

                    // direccion del negocio
                    Positioned(
                      top: 330,
                      left: 20,
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Palette.ezblue,
                            size: 20,
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Text(
                              '${widget.listaNegocios![index].direccion}, ${widget.listaNegocios![index].colonia}, ${widget.listaNegocios![index].municipio}, ${widget.listaNegocios![index].estado}, ${widget.listaNegocios![index].codigoPostal}',
                              style: TextStyle(
                                color: Palette.ezblue,
                                fontSize: 11,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  imagenesCategoria({required int index}){  
    // quitamos los acentos del nombre del negocio para obtener la ruta de la imagen 
    String  nombreNegocio = quitarAcentos(widget.listaNegocios![index].nombreComercial);

    // retornamos la imagen dependiendo de la categoria
    if(widget.listaNegocios![index].idCategoria == '2'){
      return image(
        rutaImagen: '${direccionImagen}CERAMICAS/$nombreNegocio/${nombreNegocio}1.jpg'
      );
    }else if(widget.listaNegocios![index].idCategoria == '7'){
      return image(
        rutaImagen: '${direccionImagen}Hospedaje/$nombreNegocio/${nombreNegocio}1.jpg'
      );
    }else if(widget.listaNegocios![index].idCategoria == '8'){
      return image(
        rutaImagen: '${direccionImagen}RestaurantesyBares/$nombreNegocio/${nombreNegocio}1.jpg',
      );
    }
  }

  image({
    required String rutaImagen,
  }){
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        height: 250,
        width: 200,
        color: Colors.grey,
        child: CachedNetworkImage(
          imageUrl: rutaImagen,
          imageBuilder: contenedorImagen,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: errorCarga,
        )
      ),
    );
  }

  // metodos para mostrar la imagen de la api guardada en el cache
  Widget contenedorImagen(BuildContext context, ImageProvider<Object> imageProvider) {
    return Container(
      height: 250,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // metodo para mostrar un widget de error si no se puede cargar la imagen
  Widget errorCarga(BuildContext context, String url, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100,
                color: Colors.grey,
                colorBlendMode: BlendMode.color,
                fit: BoxFit.contain,
              ),
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
        ),
      ),
    );

  }

  


}