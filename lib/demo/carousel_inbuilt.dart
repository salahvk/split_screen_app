import 'package:flutter/material.dart';

class InfiniteImageCarousel extends StatefulWidget {
  const InfiniteImageCarousel({super.key});

  @override
  _InfiniteImageCarouselState createState() => _InfiniteImageCarouselState();
}

class _InfiniteImageCarouselState extends State<InfiniteImageCarousel> {
  List<String> imageList = [
    'https://oxicodes.in/digitalarts.com/demo/public/assets/uploads/media/168430323164646d7f5de34.jpg',
    'https://oxicodes.in/digitalarts.com/demo/public/assets/uploads/media/168430323164646d7f5ee84.jpg',
    'https://cdn.britannica.com/65/162465-050-9CDA9BC9/Alps-Switzerland.jpg',
    // Add more image URLs as needed
  ];

  PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    // modifiedList = widget.imageList.map((item) => "$endPoint$item").toList();

    _pageController = PageController(initialPage: _currentPage);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void _stopAutoPlay() {
    _pageController.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });

    if (index == imageList.length + 1) {
      // Reached the end, go back to the first item
      print(index);
      _pageController.jumpToPage(
        1,
      );
    } else if (index == 0) {
      // Reached the beginning, go to the last item
      _pageController.jumpToPage(imageList.length);
    }

    _startAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemBuilder: (BuildContext context, int index) {
        final int imageIndex = index == 0
            ? imageList.length - 1
            : index == imageList.length + 1
                ? 0
                : index - 1;

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            imageList[imageIndex],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
