import 'package:flutter/material.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';

class CarouselSlider1 extends StatefulWidget {
  final double size;
  final double height;
  final List<String> imageList;
  final int dur;
  var ani;
  CarouselSlider1(
      {Key? key,
      required this.size,
      required this.height,
      required this.imageList,
      required this.dur,
      required this.ani})
      : super(key: key);

  @override
  State<CarouselSlider1> createState() => _CarouselSlider1State();
}

class _CarouselSlider1State extends State<CarouselSlider1> {
  List<String>? modifiedList;
  PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 1;
  Curve curve = Curves.ease;

  @override
  void initState() {
    super.initState();
    modifiedList = widget.imageList.map((item) => "$endPoint$item").toList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        if (widget.ani == 'ease-in') {
          curve = Curves.ease;
        } else if (widget.ani == 'ease-out') {
          curve = Curves.easeOut;
        } else if (widget.ani == 'linear') {
          curve = Curves.linear;
        } else {
          curve = Curves.ease;
          print("ease");
        }
      });
    });

    _pageController = PageController(initialPage: _currentPage);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _stopAutoPlay();

    super.dispose();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      print(_currentPage);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: curve,
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

    if (index == widget.imageList.length + 1) {
      // Reached the end, go back to the first item
      print(index);
      _pageController.jumpToPage(
        1,
        // duration: const Duration(milliseconds: 500), curve: curve
      );
    } else if (index == 0) {
      // Reached the beginning, go to the last item
      _pageController.jumpToPage(widget.imageList.length);
    }

    _startAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    // Use map method to add the string to every value in the list

    return Expanded(
      child: SizedBox(
        width: widget.size,
        height: widget.height,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemBuilder: (BuildContext context, int index) {
                final int imageIndex = index == 0
                    ? widget.imageList.length - 1
                    : index == widget.imageList.length + 1
                        ? 0
                        : index - 1;

                return SizedBox(
                  child: Image.network(
                    modifiedList?[imageIndex] ?? '',
                    fit: BoxFit.cover,
                  ),
                );
              },
            )),
      ),
    );
  }
}

// class CarouselSlider2 extends StatefulWidget {
//   final double size;
//   final double height;
//   final List<String> imageList;
//   final int dur;

//   const CarouselSlider2({
//     Key? key,
//     required this.size,
//     required this.height,
//     required this.imageList,
//     required this.dur,
//   }) : super(key: key);

//   @override
//   State<CarouselSlider2> createState() => _CarouselSlider2State();
// }

// class _CarouselSlider2State extends State<CarouselSlider2> {
//   List<String>? modifiedList;
//   @override
//   void initState() {
//     super.initState();
//     modifiedList = widget.imageList.map((item) => "$endPoint$item").toList();

//     // Output the modified list
//     print(modifiedList); // Output: [apple fruit, banana fruit, orange fruit]
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Use map method to add the string to every value in the list

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(14),
//       child: CarouselSlider.builder(
//           options: CarouselOptions(
//             height: widget.height,
//             // // aspectRatio: 16 / 9,0
//             viewportFraction: 1,

//             // enableInfiniteScroll: true,
//             // reverse: false,
//             autoPlay: true,
//             // autoPlayInterval: const Duration(milliseconds: 1),
//             // autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             // autoPlayCurve: Curves.fastOutSlowIn,
//             // enlargeCenterPage: true,
//             // enlargeFactor: 0.3,
//             scrollDirection: Axis.horizontal,
//           ),
//           itemCount: modifiedList?.length,
//           itemBuilder:
//               (BuildContext context, int itemIndex, int pageViewIndex) {
//             print(itemIndex);
//             print(modifiedList?.length);
//             return CachedNetworkImage(
//               imageUrl: modifiedList?[itemIndex] ?? '',
//               fit: BoxFit.cover,
//             );
//           }),
//     );
//   }
// }

class CarouselSlider2 extends StatefulWidget {
  final double size;
  final double height;
  final List<String> imageList;
  final int dur;
  var ani;

  CarouselSlider2({
    Key? key,
    required this.ani,
    required this.size,
    required this.height,
    required this.imageList,
    required this.dur,
  }) : super(key: key);

  @override
  State<CarouselSlider2> createState() => _CarouselSlider2State();
}

class _CarouselSlider2State extends State<CarouselSlider2> {
  List<String>? modifiedList;
  PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 1;
  Curve curve = Curves.ease;
  @override
  void initState() {
    super.initState();
    modifiedList = widget.imageList.map((item) => "$endPoint$item").toList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        if (widget.ani == 'ease-in') {
          curve = Curves.ease;
        } else if (widget.ani == 'ease-out') {
          curve = Curves.easeOut;
        } else if (widget.ani == 'linear') {
          curve = Curves.linear;
        } else {
          curve = Curves.ease;
          print("ease");
        }
      });
    });
    _pageController = PageController(initialPage: _currentPage);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _stopAutoPlay();
    // _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      _pageController.nextPage(
        duration: Duration(microseconds: widget.dur),
        curve: curve,
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

    if (index == widget.imageList.length + 1) {
      // Reached the end, go back to the first item
      print(index);
      _pageController.jumpToPage(
        1,
      );
    } else if (index == 0) {
      // Reached the beginning, go to the last item
      _pageController.jumpToPage(widget.imageList.length);
    }

    _startAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    // Use map method to add the string to every value in the list

    return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemBuilder: (BuildContext context, int index) {
            final int imageIndex = index == 0
                ? widget.imageList.length - 1
                : index == widget.imageList.length + 1
                    ? 0
                    : index - 1;

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                modifiedList?[imageIndex] ?? '',
                fit: BoxFit.cover,
              ),
            );
          },
        ));
  }
}
