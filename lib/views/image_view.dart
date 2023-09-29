import 'package:ezahora/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageView extends StatefulWidget {

  final String imageUrl;
  final String title;
  final int index;


  const ImageView({ 
    required this.imageUrl,
    required this.title,
    required this.index,
    Key? key
  }) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.index,
      viewportFraction: 1
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.ezPink,
        title: Text(widget.title)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              width: double.maxFinite,
              child: PageView.builder(
                
                controller: pageController,
                itemCount: 5,
                itemBuilder: (context, index) {
                  index++;
                  return Image.network(
                    '${widget.imageUrl}$index.jpg',
                      width: double.maxFinite,
                      height: 400,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SmoothPageIndicator(
              controller: pageController,
              count: 5,
              effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Palette.ezPink.withOpacity(0.7),
                activeDotColor: Palette.ezPink
              ),
            ),
          ],
        ),
      ),
    );
  }
}