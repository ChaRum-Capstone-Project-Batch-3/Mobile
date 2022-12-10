import 'package:fgd_flutter/shared/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:fgd_flutter/models/login.dart';
import 'package:fgd_flutter/providers/login_view_model.dart';
import 'package:fgd_flutter/shared/app_colors.dart';
import 'package:fgd_flutter/shared/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController teEmail = TextEditingController();
  TextEditingController tePass = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    teEmail.dispose();
    tePass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.kcBaseBlack,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'You’ve been missed. You can sign in first to see any threads you searching for.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 54,
                  ),
                  TextFormField(
                    controller: teEmail,
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: tePass,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.visibility_outlined,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF178066),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              backgroundColor: Color(0xffffffff),
                              content: Container(
                                height: 250,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset('assets/loading.json'),
                                      Text(
                                        'Please wait...',
                                        style: body1.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ]),
                              ));
                        },
                      );
                      Login login =
                          Login(key: teEmail.text, password: tePass.text);
                      var response = provider.login(login);
                      await response.whenComplete(() async {
                        await response.then((value) {
                          print(value.toString());
                          if (value) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, home, (route) => false);
                          }
                        });
                      });
                    },
                    // style: ElevatedButton.styleFrom(
                    //   primary: const Color(0xFF178066),
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20, vertical: 10),
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    // ),
                    child: Text(
                      'Sign In',
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or sign in with',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF909090),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      IconButton(icon: 'assets/Google.png'),
                      SizedBox(
                        width: 24,
                      ),
                      IconButton(icon: 'assets/Facebook.png'),
                      SizedBox(
                        width: 24,
                      ),
                      IconButton(icon: 'assets/Twitter.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sing up here!',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF178066),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      actionsPadding: EdgeInsets.only(
                                          left: 30, right: 30, bottom: 20),
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      backgroundColor: Color(0xffffffff),
                                      title: const Text(
                                        'Confirmation',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Container(
                                        height: 60,
                                        child: Text(
                                          'Are you sure want to register with credentials that you filled in the register column?',
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor:
                                                    Color(0xff178066),
                                                backgroundColor: Colors.white,
                                              ),
                                              onPressed: (() {
                                                Navigator.pop(context);
                                              }),
                                              child: Text('No, I don\'t'),
                                            ),
                                            ElevatedButton(
                                              onPressed: (() {
                                                Navigator.pushNamed(
                                                    context, register);
                                              }),
                                              child: Text('Yes, I am'),
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  String? _validateEmail(String? value) {
    if (_isEmailValid(value!)) {
      return 'Wrong Format';
    } else {
      return null;
    }
  }

  bool _isEmailValid(String email) {
    String regexPattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\[a-zA-Z]+';
    var regExp = RegExp(regexPattern);

    if (email.isEmpty) {
      return false;
    } else if (regExp.hasMatch(email)) {
      return true;
    }
    return false;
  }
}

class IconButton extends StatelessWidget {
  const IconButton({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final String? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {},
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFD9D9D9),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            // add image as icon
            child: Image(
          image: AssetImage(icon!),
        )),
      ),
    );
  }
}
