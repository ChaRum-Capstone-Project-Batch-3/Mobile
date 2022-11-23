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
                      margin: EdgeInsets.only(top: 50),
                      padding: EdgeInsets.only(
                          top: 50, right: 20, left: 20, bottom: 10),
                      child: Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffedf5f3),
                                ),
                                height: 248,
                                width: 248,
                              ),
                              Container(
                                  height: 284,
                                  width: 284,
                                  child: Image.asset(onBoards[index].image)),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.only(left: 50, right: 50),
                            child: Text(
                              textAlign: TextAlign.center,
                              onBoards[index].title,
                              style: heading4Bold.copyWith(
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            onBoards[index].description,
                            style: buttonSemi,
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
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.only(top: 24, bottom: 24, left: 20, right: 20),
              child: currentIndex == onBoards.length - 1
                  ? MaterialButton(
                      onPressed: () async {
                        _controller.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      },
                      color: primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Get Started",
                        style: body2Semi.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextButton(
                            onPressed: () {
                              _controller.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              'Skip',
                              style: body2Semi.copyWith(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: MaterialButton(
                            height: 50,
                            elevation: 0.0,
                            onPressed: () {
                              _controller.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeInOut,
                              );
                            },
                            color: primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Next',
                              style: body2Semi.copyWith(
                                color: Colors.white,
                              ),
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
