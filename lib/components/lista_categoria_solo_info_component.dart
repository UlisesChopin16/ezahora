import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezahora/models/negocios_model.dart';
import 'package:ezahora/views/image_view.dart';
import 'package:flutter/material.dart';


// tenemos que adaptarlo a una pequeña reseña
// al momento de tocarlo lanzara la pagina de imagenes negocios para que vean mas grande las pagina

class ListaCategoriaInfoComponent extends StatefulWidget {

  final int contador;
  final List<Negocios>? listaNegocios;

  final ScrollController scrollController;

  const ListaCategoriaInfoComponent({ 
    Key? key, 

    // Aqui se reciben los parametros
    required this.contador,
    required this.scrollController,
    this.listaNegocios

  }) : super(key: key);

  @override
  _ListaCategoriaInfoComponentState createState() => _ListaCategoriaInfoComponentState();
}

class _ListaCategoriaInfoComponentState extends State<ListaCategoriaInfoComponent> {
  
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
    cadena = cadena.replaceAll('“', '');
    cadena = cadena.replaceAll('”', '');
    cadena = cadena.replaceAll('.', '');

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

    
    return cadena.trim();
  }


  @override
  Widget build(BuildContext context){
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: widget.contador,
      itemBuilder: (context, index) {

        final negocios = widget.listaNegocios![index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: InkWell(
            onTap: () {
              setState(() {

                // ruta de las carpetas de las imagenes
                if(negocios.idCategoria == '1'){
                  direccionCarpetaImagen = '${direccionImagen}Atractivos/';
                }else if(negocios.idCategoria == '4'){
                  direccionCarpetaImagen = '${direccionImagen}Fiestas/';
                }
              });

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ImageView(
                    // mandamos la ruta de la imagen, el nombre del negocio y la posicion de la imagen
                    imageUrl: '$direccionCarpetaImagen${quitarAcentos(negocios.nombreComercial)}/${quitarAcentos(negocios.nombreComercial)}',
                    title: negocios.nombreComercial,
                    categoria: negocios.idCategoria,
                    resena: negocios.comentarios,
                    index: 0,
                  ),
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
                height: 480,
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
                        negocios.nombreComercial,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),

                    // resena corta
                    Positioned(
                      top: 320,
                      left: 20,
                      right: 20,
                      child: Text(
                        negocios.comentarios,
                        textAlign: TextAlign.justify,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 11,
                          fontWeight: FontWeight.bold
                        ),
                      )
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
    
    // quitamos los acentos del nombre del negocio para poder acceder a la carpeta de la imagen
    String  nombreNegocio = quitarAcentos(widget.listaNegocios![index].nombreComercial);

    // retornamos la imagen dependiendo de la categoria
    if(widget.listaNegocios![index].idCategoria == '1'){
      return image(
        rutaImagen: '${direccionImagen}Atractivos/$nombreNegocio/${nombreNegocio}1.jpg',
      );
    }else if(widget.listaNegocios![index].idCategoria == '4'){
      return image(
        rutaImagen: '${direccionImagen}Fiestas/$nombreNegocio/${nombreNegocio}1.jpg',
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

  // metodo para mostrar la imagen guardada en cache
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

  // metodo para mostrar el error de la imagen
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