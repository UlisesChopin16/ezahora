import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListaCategoriaImagenComponent extends StatefulWidget {

  final int contador;
  final int categoria;
  final String resena;
  final String tituloResena;

  final ScrollController scrollController;


  const ListaCategoriaImagenComponent({ 
    Key? key, 

    // Aqui se reciben los parametros
    required this.contador,
    required this.categoria,
    required this.resena,
    required this.tituloResena,
    required this.scrollController

  }) : super(key: key);

  @override
  _ListaCategoriaImagenComponentState createState() => _ListaCategoriaImagenComponentState();
}

class _ListaCategoriaImagenComponentState extends State<ListaCategoriaImagenComponent> {
  
  String direccionImagen = 'https://ezahora.com/turismo/APP1/';
  String direccionCarpetaImagen = '';

  double w = 0;
  double h = 0;

  // metodo para obtener el ancho y alto de la pantalla
  void getScreenSize() {
    setState(() {
      w = MediaQuery.of(context).size.width;
      h = MediaQuery.of(context).size.height;
    });
  }

  @override
  void initState() {
    super.initState();
    
    // direccion de la api donde se encuentran las imagenes
    if(widget.categoria == 3){
      direccionCarpetaImagen = '${direccionImagen}Mercados/Mercado';
    }else if(widget.categoria == 5){
      direccionCarpetaImagen = '${direccionImagen}Carnaval/Carnaval';
    }else if(widget.categoria == 9){
      direccionCarpetaImagen = '${direccionImagen}Gastronomia/Gastronomia';
    }
    
  }

  @override
  Widget build(BuildContext context){
    getScreenSize();
    return CustomScrollView(
      controller: widget.scrollController,
      slivers: [

        // titulo de la reseña
        tituloResena(),

        // reseña
        textoResena(),

        SliverList.builder(
          itemCount: widget.contador,
          itemBuilder: (context, index) {
            index++;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
                        bottom: 0,
                        child: image(
                          rutaImagen: '$direccionCarpetaImagen$index.jpg'
                        )
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  tituloResena(){
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Text(
          widget.tituloResena,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  textoResena(){
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Text(
          widget.resena,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }


  image({
    required String rutaImagen,
  }){
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        imageUrl: rutaImagen,
        imageBuilder: contenedorImagen,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: errorCarga,
      ),
    );
  }

  Widget contenedorImagen(BuildContext context, ImageProvider<Object> imageProvider) {
    return Container(
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