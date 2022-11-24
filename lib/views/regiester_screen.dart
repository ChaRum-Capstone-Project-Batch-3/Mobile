import 'package:fgd_flutter/shared/box_text.dart';
import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    pass.dispose();
    confPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 60,
                  ),
                  BoxText.heading3Semi("Create new account"),
                  SizedBox(
                    height: 4,
                  ),
                  BoxText.body2(
                      "Lorem ipsum dolor sit amet consectetur.  \nVolutpat sit fringilla tempor interdum."),
                  SizedBox(
                    height: 54,
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return "Nama harus terisi";
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
                        return "Email harus terisi";
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
                        return "Password harus terisi";
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
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                        return "Password tidak sama";
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
                    height: 52,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
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
                                  child: Icon(
                                    Icons.facebook,
                                    size: 20,
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
                                  child: Icon(
                                    Icons.facebook,
                                    size: 20,
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
                                  child: Icon(
                                    Icons.facebook,
                                    size: 20,
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
  }
}
