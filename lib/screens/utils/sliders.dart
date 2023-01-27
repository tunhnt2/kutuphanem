import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Sliders extends StatelessWidget {
  const Sliders({
    Key? key,
    required this.imgs,
  }) : super(key: key);

  final List imgs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
            itemCount: imgs.length,
            itemBuilder: (ctx, i, m) {
              return Container(
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                image: NetworkImage(imgs[i]),
              ));
            },
            options: CarouselOptions(
                height: 200, autoPlay: true, viewportFraction: 1))
      ],
    );
  }
}
