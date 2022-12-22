import 'package:fgd_flutter/shared/styles.dart';
import 'package:fgd_flutter/state/login_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:fgd_flutter/models/login/login.dart';
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
  bool obPass = true;

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
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return "This field is required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: "Username / Email",
                      hintText: "Username / Email",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: tePass,
                    validator: (value) {
                      if (value == '' || value!.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                    obscureText: obPass,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obPass = !obPass;
                          });
                        },
                        icon: Icon(
                          obPass
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
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
                      Login login =
                          Login(key: teEmail.text, password: tePass.text);
                      var response = provider.login(login);
                      if (provider.state == LoginState.loading) {
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Lottie.asset('assets/loading.json'),
                                    Text(
                                      'Please wait...',
                                      style: body1.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      await response.whenComplete(() async {
                        await response.then((value) async {
                          print(
                              "Login Status :" + provider.isSuccess.toString());
                          if (provider.isSuccess) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, home, (route) => false);
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Username / Email or Password is Wrong'),
                              ),
                            );
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
                      ButtonIcon(icon: 'assets/Google.png'),
                      SizedBox(
                        width: 24,
                      ),
                      ButtonIcon(icon: 'assets/Facebook.png'),
                      SizedBox(
                        width: 24,
                      ),
                      ButtonIcon(icon: 'assets/Twitter.png'),
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
                            text: 'Sign up here!',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF178066),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, register);
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

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
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
