import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';

class CarouselSlider1 extends StatefulWidget {
  final double size;
  final double height;
  final List<String> imageList;
  final int dur;

  const CarouselSlider1({
    Key? key,
    required this.size,
    required this.height,
    required this.imageList,
    required this.dur,
  }) : super(key: key);

  @override
  State<CarouselSlider1> createState() => _CarouselSlider1State();
}

class _CarouselSlider1State extends State<CarouselSlider1> {
  List<String>? modifiedList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    modifiedList = widget.imageList.map((item) => "$endPoint$item").toList();

    // Output the modified list
    print(modifiedList); // Output: [apple fruit, banana fruit, orange fruit]
  }

  @override
  Widget build(BuildContext context) {
    // Use map method to add the string to every value in the list

    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: widget.height,
            // aspectRatio: 16 / 9,0
            viewportFraction: 10,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(milliseconds: widget.dur),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          ),
          itemCount: modifiedList?.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  CachedNetworkImage(
            imageUrl: modifiedList?[itemIndex] ?? '',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
