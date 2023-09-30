import 'package:ezahora/constants/colors.dart';
import 'package:ezahora/models/negocios_model.dart';
import 'package:ezahora/views/negocios_view.dart';
import 'package:flutter/material.dart';


// tenemos que adaptarlo a una pequeña reseña
// al momento de tocarlo lanzara la pagina de imagenes negocios para que vean mas grande las pagina

class ListaCategoriaComponent extends StatefulWidget {

  final int contador;
  final String resena;
  final List<Negocios>? listaNegocios;

  const ListaCategoriaComponent({ 
    Key? key, 

    // Aqui se reciben los parametros
    required this.contador,
    required this.resena,
    this.listaNegocios

  }) : super(key: key);

  @override
  _ListaCategoriaComponentState createState() => _ListaCategoriaComponentState();
}

class _ListaCategoriaComponentState extends State<ListaCategoriaComponent> {
  
  String direccionImagen = '';  

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: widget.contador,
      itemBuilder: (context, index) {

        final negocios = widget.listaNegocios![index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: InkWell(
            onTap: () {
              setState(() {

                // direccion de la imagen
                if(widget.listaNegocios![index].idCategoria == '1'){
                  direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/Atractivos/';
                }else if(widget.listaNegocios![index].idCategoria == '2'){
                  direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/CERAMICAS/';
                }else if(widget.listaNegocios![index].idCategoria == '3'){
                  direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/Mercados/';
                }else if(widget.listaNegocios![index].idCategoria == '4'){
                  direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/Fiestas/';
                }else if(widget.listaNegocios![index].idCategoria == '5'){
                  direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/Carnaval/';
                }else if(widget.listaNegocios![index].idCategoria == '6'){
                  direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/Ecoturismo/';
                }else if(widget.listaNegocios![index].idCategoria == '7'){
                  direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/Hospedaje/';
                }else if(widget.listaNegocios![index].idCategoria == '8'){
                  direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/RestaurantesyBares/';
                }else if(widget.listaNegocios![index].idCategoria == '9'){
                  direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/Gastronomia/';
                }
              });

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NegociosView(
                    nombreNegocio: negocios.nombreComercial, 
                    direccion: '${negocios.direccion}, ${negocios.colonia}, ${negocios.municipio}, ${negocios.estado}, ${negocios.codigoPostal}',
                    linkDireccion: negocios.linkDireccion,
                    telefono: negocios.telefono, 
                    redSocial: negocios.redesSociales, 
                    descripcion: negocios.comentarios, 
                    direccionImagen: direccionImagen
                  )
                )
              );

              // print(widget.listaNegocios![index].idUsuario);
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
    
    String  nombreNegocio = quitarAcentos(widget.listaNegocios![index].nombreComercial);
    if(widget.listaNegocios![index].idCategoria == '1'){
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          height: 250,
          width: 200,
          color: Colors.grey,
          child: Image.network(
            'https://turismo.zapatamorelos.gob.mx/APP1/Atractivos/$nombreNegocio/${nombreNegocio}1.jpg',
            height: 250,
            width: 200,
            fit: BoxFit.cover,
          )
        ),
      );
    }else if(widget.listaNegocios![index].idCategoria == '2'){
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          height: 250,
          width: 200,
          color: Colors.grey,
          child: Image.network(
            'https://turismo.zapatamorelos.gob.mx/APP1/CERAMICAS/$nombreNegocio/${nombreNegocio}1.jpg',
            height: 250,
            width: 200,
            fit: BoxFit.cover,
          )
        ),
      );
    }else if(widget.listaNegocios![index].idCategoria == '4'){
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          height: 250,
          width: 200,
          color: Colors.grey,
          child: Image.network(
            'https://turismo.zapatamorelos.gob.mx/APP1/Fiestas/$nombreNegocio/${nombreNegocio}1.jpg',
            height: 250,
            width: 200,
            fit: BoxFit.cover,
          )
        ),
      );
    }else if(widget.listaNegocios![index].idCategoria == '7'){
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          height: 250,
          width: 200,
          color: Colors.grey,
          child: Image.network(
            'https://turismo.zapatamorelos.gob.mx/APP1/Hospedaje/$nombreNegocio/${nombreNegocio}1.jpg',
            height: 250,
            width: 200,
            fit: BoxFit.cover,
          )
        ),
      );
    }else if(widget.listaNegocios![index].idCategoria == '8'){
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          height: 250,
          width: 200,
          color: Colors.grey,
          child: Image.network(
            'https://turismo.zapatamorelos.gob.mx/APP1/RestaurantesyBares/$nombreNegocio/${nombreNegocio}1.jpg',
            height: 250,
            width: 200,
            fit: BoxFit.cover,
          )
        ),
      );
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


}