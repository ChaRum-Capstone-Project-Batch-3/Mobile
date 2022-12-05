import 'package:fgd_flutter/models/register.dart';
import 'package:fgd_flutter/providers/register_view_model.dart';
import 'package:fgd_flutter/shared/box_text.dart';
import 'package:fgd_flutter/shared/router.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
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
                        if (value!.isEmpty || value == '') {
                          return "Email is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
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
                        if (value!.isEmpty || value == '') {
                          return "Password is required";
                        }
                        return null;
                      },
                      obscureText: obPass,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obPass = !obPass;
                              });
                            },
                            icon: Icon(obPass
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          )),
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
                          Register register = Register(
                            displayName: name.text,
                            userName: teUser.text,
                            email: email.text,
                            password: pass.text,
                          );
                          var result = provider.register(register);
                          await result.whenComplete(() async {
                            await result.then((value) {
                              if (value) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, home, (route) => false);
                              }
                            });
                          });
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
