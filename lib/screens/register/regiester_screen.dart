import 'dart:ffi';

import 'package:fgd_flutter/models/register/register.dart';
import 'package:fgd_flutter/providers/register_view_model.dart';
import 'package:fgd_flutter/shared/box_text.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:fgd_flutter/state/register_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obPass = true;
  bool obConPass = true;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confPass = TextEditingController();
  TextEditingController teUser = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    teUser.dispose();
    name.dispose();
    email.dispose();
    pass.dispose();
    confPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kcBaseWhite,
          foregroundColor: AppColors.kcBaseBlack,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoxText.heading3Semi("Create new account"),
                  SizedBox(
                    height: 4,
                  ),
                  BoxText.body2(
                      "Let’s make a new account for you to see or create any threads in charum."),
                  SizedBox(
                    height: 54,
                  ),
                  TextFormField(
                    controller: teUser,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return "Username is required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "Username",
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
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return "Name is required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Name",
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
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      if (RegExp(r"^((?!\.)[\w-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$")
                              .hasMatch(value!) ==
                          false) {
                        return "Invalid Email Address";
                      }
                      if (value!.isEmpty || value == '') {
                        return "Email is required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      hintText: "Email Address",
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
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: pass,
                    validator: (value) {
                      if (value!.length < 8) {
                        return "Password must be at least 8 character";
                      }
                      if (value!.contains(new RegExp(
                              r"""((?=\S*[A-Z])(?=\S*[a-z])(?=\S*\d)(?=\S*[\!\"\§\$\%\&\/\(\)\=\?\+\*\#\'\^\°\,\;\.\:\<\>\ä\ö\ü\Ä\Ö\Ü\ß\?\|\@\~\´\`\\])\S{8,})""")) ==
                          false) {
                        return "This field must contain at least one special character, one uppercase letter, one lowercase letter, and one number";
                      }
                      if (value!.isEmpty || value == '') {
                        return "Password is required";
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
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: confPass,
                    validator: (value) {
                      if (value != pass.text) {
                        return "Password not match";
                      }
                      return null;
                    },
                    obscureText: obConPass,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
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
                            obConPass = !obConPass;
                          });
                        },
                        icon: Icon(obConPass
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
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
                                  child: const Text(
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
                                          foregroundColor: Color(0xff178066),
                                          backgroundColor: Colors.white,
                                        ),
                                        onPressed: (() {
                                          Navigator.pop(context);
                                        }),
                                        child: Text('No, I don\'t'),
                                      ),
                                      ElevatedButton(
                                        onPressed: (() async {
                                          Register register = Register(
                                            displayName: name.text,
                                            userName: teUser.text,
                                            email: email.text,
                                            password: pass.text,
                                          );
                                          var result =
                                              provider.register(register);
                                          if (provider.state ==
                                              RegisterState.loading) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  elevation: 0.0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  backgroundColor:
                                                      Color(0xffffffff),
                                                  content: Container(
                                                    height: 250,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Lottie.asset(
                                                            'assets/loading.json'),
                                                        Text(
                                                          'Please wait...',
                                                          style: body1.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                          await result.whenComplete(() async {
                                            await result.then((value) {
                                              if (provider.isSuccess == true) {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        home,
                                                        (route) => false);
                                              } else {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content:
                                                        Text(provider.mError),
                                                  ),
                                                );
                                              }
                                            });
                                          });
                                        }),
                                        child: Text('Yes, I am'),
                                      )
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Center(
                    child: Container(
                      width: 161,
                      child: Column(
                        children: [
                          Text(
                            "Or sign up with",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff909090),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: Color(0xffD8D8D8),
                                      )),
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('assets/Google.png'),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: Color(0xffD8D8D8),
                                      )),
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('assets/Facebook.png'),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: Color(0xffD8D8D8),
                                      )),
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('assets/Twitter.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Have an Account?',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: ' Sign in here!',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF178066),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, login);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
