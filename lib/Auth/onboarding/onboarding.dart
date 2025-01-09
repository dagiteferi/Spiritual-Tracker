import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neh/Auth/login.dart';
import 'package:neh/Auth/register.dart'; // Import RegisterPage
import 'package:dots_indicator/dots_indicator.dart';

// Define your custom colors and image paths
class AppImagePath {
  static String kOnboarding1 = 'assets/logoo.jpg';
  static String kOnboarding2 = 'assets/logoo.jpg';
  static String kOnboarding3 = 'assets/logoo.jpg';
}

class AppColor {
  static Color kPrimary = const Color(0XFFCA7CD8);
  static Color kBackGroundColor = const Color(0XFF2D3047);
  static Color kLightAccentColor = const Color(0XFFF4E5F7);
  static Color kGrey3Color = const Color(0XFF272828);
  static Color kBGColor = const Color(0XFF181A1A);
  static Color kBlackColor = const Color(0XFF000000);
  static Color kWhiteColor = const Color(0XFFFFFFFF);
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kBGColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 61.65, right: 43.75, top: 121.76),
              child: Image.asset(
                pageViewList[_currentPage].image,
                fit: BoxFit.cover, // Ensures the image fits within the widget bounds
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                                dataList: null,
                              )),
                    );
                  },
                  child: Text('Skip'),
                ),
                Row(
                  children: List.generate(4, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: _currentPage == index ? 12.0 : 8.0,
                      height: _currentPage == index ? 12.0 : 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentPage == index ? Colors.blue : Colors.grey,
                      ),
                    );
                  }),
                ),
                TextButton(
                  onPressed: () {
                    if (_currentPage == 3) {
                      // Navigate to LoginPage after onboarding
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(dataList: null)),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Text('Next'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final IconData? iconData;
  final Color? textColor, bgColor;
  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    required this.textColor,
    required this.bgColor,
    this.iconData,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);

@override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
          ),
          child: Container(
            height: widget.height ?? 55,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.iconData != null) ...[
                  Icon(
                    widget.iconData,
                    color: AppColor.kWhiteColor,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: widget.fontSize ?? 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingCard extends StatelessWidget {
  final List<OnBoarding> onBoardingList;
  final int currentIndex;
  final PageController pageController;

  const OnboardingCard({
    Key? key,
    required this.onBoardingList,
    required this.currentIndex,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.kGrey3Color,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 35, right: 34),
            child: Text(
              onBoardingList[currentIndex].title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: AppColor.kLightAccentColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: DotsIndicator(
              dotsCount: onBoardingList.length,
              position: currentIndex.toDouble(),
              decorator: DotsDecorator(
                color: Colors.grey.withOpacity(0.5),
                size: const Size.square(8.0),
                activeSize: const Size(20.0, 8.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: AppColor.kPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoarding {
  final String title;
  final String image;

  OnBoarding({
    required this.title,
    required this.image,
  });
}

List<OnBoarding> pageViewList = [
  OnBoarding(
    title: 'Receive daily Bible verses and short devotions to inspire your faith.',
    image: AppImagePath.kOnboarding1,
  ),
  OnBoarding(
    title: 'Submit your prayer requests and join in communal prayers.',
    image: AppImagePath.kOnboarding2,
  ),
  OnBoarding(
    title: 'Stay updated with upcoming church events and services.',
    image: AppImagePath.kOnboarding3,
  ),
  OnBoarding(
    title: 'Access recorded sermons to deepen your understanding of the Word.',
    image: AppImagePath.kOnboarding3,
  ),
];
