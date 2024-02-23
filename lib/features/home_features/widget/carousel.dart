import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constant/responsive.dart';
import '../../../constant/shape/border_radius.dart';
import '../../../constant/shape/media_query.dart';
import '../../../constant/theme/colors.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({
    super.key,
  });

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  final CarouselController carouselController = CarouselController();

  List<String> imgSliders = [
    "assets/images/post-1.jpg",
    "assets/images/post-2.jpg",
  ];
  int currentImg = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //!CarouselSlider
        CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: imgSliders.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: getBorderRadiusFunc(7.5),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/images/logo.png'),
                      image: AssetImage(imgSliders[index]),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/logo.png');
                      },
                      placeholderErrorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: Responsive.isTablet(context)
                  ? getWidth(context, 0.33)
                  : getWidth(context, 0.45),
              viewportFraction: 0.9,
              initialPage: currentImg,
              enableInfiniteScroll: true,
              reverse: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  currentImg = index;
                });
              },
            )),
        SizedBox(
          height: 5.sp,
        ),
        AnimatedSmoothIndicator(
          activeIndex: currentImg,
          onDotClicked: (index) {
            setState(() {
              currentImg = index;
              carouselController.animateToPage(index);
            });
          },
          effect: ExpandingDotsEffect(
              activeDotColor: primaryColor,
              dotWidth: Responsive.isTablet(context) ? 5.sp : 8.5.sp,
              dotHeight: Responsive.isTablet(context) ? 5.sp : 8.5.sp),
          count: imgSliders.length,
        )
      ],
    );
  }
}
