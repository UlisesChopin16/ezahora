import 'package:ezahora/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageView extends StatefulWidget {

  // pedimos el titulo, el url y el index
  final String imageUrl;
  final String title;
  final int index;
  final String? categoria;
  final String? resena;


  const ImageView({ 
    required this.imageUrl,
    required this.title,
    required this.index,
    this.categoria,
    this.resena,
    Key? key
  }) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  // controlador de la pagina
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    // inicializamos el controlador
    pageController = PageController(
      initialPage: widget.index,
      viewportFraction: 1,
      // keepPage sirve para que no se pierda la pagina en la que se encuentra
      keepPage: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              construccionImagenes(),
              const SizedBox(height: 10,),
              indicadorImagenNegocio(),
              if(widget.categoria == '1' || widget.categoria == '4')
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.resena!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7)
                    )
                  ),
                )
              else
                const SizedBox(),
              SizedBox(height: 60,)
            ],
          ),
        ),
      ),
    );
  }

  appBar(){
    return AppBar(
      backgroundColor: Palette.ezPink,
      title: Text(widget.title)
    );
  }


  construccionImagenes(){
    return SizedBox(
      height: 400,
      width: double.maxFinite,
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.categoria == '1' || widget.categoria == '4' ? 2 : 5,
        itemBuilder: (context, index) {
          index++;
          return Image.network(
            '${widget.imageUrl}$index.jpg',
            width: double.maxFinite,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 400,
                width: double.maxFinite,
                color: Colors.grey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'Imagen no disponible',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7)
                      )
                    )
                  ],
                ),
              );
            },
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }


  indicadorImagenNegocio(){
    return SmoothPageIndicator(
      controller: pageController,
      count: widget.categoria == '1' || widget.categoria == '4' ? 2 : 5,
      effect: ExpandingDotsEffect(
        dotHeight: 10,
        dotWidth: 10,
        dotColor: Palette.ezPink.withOpacity(0.7),
        activeDotColor: Palette.ezPink
      ),
    );
  }

}

// flutter build apk --release