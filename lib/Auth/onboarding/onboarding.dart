import 'package:flutter/material.dart';
import 'package:neh/Auth/login.dart';
import 'package:neh/Auth/register.dart'; // Import RegisterPage

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  OnboardingContent(
                    image: 'assets/versee.jpg',
                    title: 'Daily Bible Verses',
                    description:
                        'Receive daily Bible verses and short devotions to inspire your faith.',
                  ),
                  OnboardingContent(
                    image: 'assets/pr.jpg',
                    title: 'Prayer Requests',
                    description:
                        'Submit your prayer requests and join in communal prayers.',
                  ),
                  OnboardingContent(
                    image: 'assets/cal.jpeg',
                    title: 'Church Event Calendar',
                    description:
                        'Stay updated with upcoming church events and services.',
                  ),
                  OnboardingContent(
                    image: 'assets/chuu.jpg',
                    title: 'Sermon Recordings',
                    description:
                        'Access recorded sermons to deepen your understanding of the Word.',
                  ),
                ],
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

class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 300,
          height: 280,
          child: Image.asset(image, fit: BoxFit.cover),
        ),
        SizedBox(height: 10.50),
        Text(title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.0),
        Text(description,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 10.0)),
      ],
    );
  }
}
