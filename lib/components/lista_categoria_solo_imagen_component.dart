import 'package:flutter/material.dart';

class ListaCategoriaImagenComponent extends StatefulWidget {

  final int contador;
  final int categoria;
  final String resena;
  final String tituloResena;

  const ListaCategoriaImagenComponent({ 
    Key? key, 

    // Aqui se reciben los parametros
    required this.contador,
    required this.categoria,
    required this.resena,
    required this.tituloResena,

  }) : super(key: key);

  @override
  _ListaCategoriaImagenComponentState createState() => _ListaCategoriaImagenComponentState();
}

class _ListaCategoriaImagenComponentState extends State<ListaCategoriaImagenComponent> {
  
  String direccionImagen = '';

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
    
    if(widget.categoria == 3){
      direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/Mercados/Mercado';
    }else if(widget.categoria == 5){
      direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/Carnaval/Carnaval';
    }else if(widget.categoria == 9){
      direccionImagen = 'https://turismo.zapatamorelos.gob.mx/APP1/Gastronomia/Gastronomia';
    }
    
  }

  @override
  Widget build(BuildContext context){
    getScreenSize();
    return CustomScrollView(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            '$direccionImagen$index.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
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


}