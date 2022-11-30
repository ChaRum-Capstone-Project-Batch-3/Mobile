import 'package:fgd_flutter/screens/login/login_screen.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/models/onboarding.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState(false);
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _controller;
  final primaryColor = AppColors.kcPrimaryColor;

  _OnBoardingScreenState(this.revere);

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  final bool revere;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onBoards.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, index) {
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 70),
                      padding: EdgeInsets.only(
                          top: 40, right: 20, left: 20, bottom: 30),
                      child: Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom :30),
                                 width: 292,
                  
                                  child: Image.asset(onBoards[index].bgImage)),
                              Container(
                                  height: 315,
                                  width: 315,
                                  child: Image.asset(onBoards[index].image)),
                            ],
                          ),
                          // SizedBox(height: 20),
                          Text(
                            textAlign: TextAlign.center,
                            onBoards[index].title,
                            style: heading4Bold.copyWith(
                              color: Color(0xff136651),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            onBoards[index].description,
                            style: TextStyle(color: Color(0xff5C5C5C)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onBoards.length,
                  (index) => buildPage(index, context),
                ),
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              margin: EdgeInsets.only(top: 35, bottom: 24, left: 20, right: 20),
              child: currentIndex == onBoards.length - 1
                  ? ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                        _controller.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text("Get Started", style: body2Semi),
                    )
                  : Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Container(
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                _controller.nextPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeInOut,
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                'Skip',
                                style: body2Semi.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Container(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                _controller.nextPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Text('Next', style: body2Semi),
                            ),
                          ),
                        )
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  Container buildPage(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? primaryColor : Color(0xffe4e4e4),
      ),
    );
  }
}
