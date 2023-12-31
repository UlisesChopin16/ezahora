import 'package:ezahora/constants/colors.dart';
import 'package:ezahora/views/menu_principal_view.dart';
import 'package:flutter/material.dart';

class EzSplashView extends StatefulWidget {
  const EzSplashView({ Key? key }) : super(key: key);

  @override
  _EzSplashViewState createState() => _EzSplashViewState();
}

class _EzSplashViewState extends State<EzSplashView> {

  double heightValue = 0;
  double widthValue = 0;
  double opacityValue = 0;
  double opacityValue2 = 0;

  double w = 0;
  double h = 0;

  // metodo para obtener el tamaño de la pantalla
  void getScreenSize() {
    setState(() {
      w = MediaQuery.of(context).size.width;
      h = MediaQuery.of(context).size.height;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) => (
      setState(() {
        heightValue = 150;
        widthValue = 150;
      })
    ));

    Future.delayed(const Duration(milliseconds: 1600)).then((value) => (
      setState(() {
        opacityValue = 1;
      })
    ));

    Future.delayed(const Duration(milliseconds: 800)).then((value) => (
      setState(() {
        opacityValue2 = 1;
      })
    ));
    
    Future.delayed(const Duration(seconds: 4)).then((value) => (
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MenuPrincipal(),))
    ));
  }


  @override
  Widget build(BuildContext context) {
    getScreenSize();
    return  Scaffold(
      body: SafeArea(      
        bottom: false,  
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              fondoOpacoAnimado(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logoEZAnimado(),
                  palabraEZAhoraAnimado(),
                ],
              ),
              
            ],
          ),
        ),
      )
    );
  }

  fondoOpacoAnimado(){
    return AnimatedOpacity(
      opacity: opacityValue2, 
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Image.asset(
        'assets/images/background_splash.png',
        width: w,
        height: h,
        fit: BoxFit.fill,
      ),
    );
  }

  logoEZAnimado(){
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: opacityValue,
      curve: Curves.easeInOut,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: heightValue,
        width: widthValue,
        curve: Curves.easeInOut,
        child: Image.asset(
          'assets/images/ez.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  palabraEZAhoraAnimado(){
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1500),
      opacity: opacityValue,
      curve: Curves.easeInOut,
      child: Text(
        'EZAhora',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Palette.ezblue,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

}