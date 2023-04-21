import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'Homescreen.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

TextEditingController emailcontroller = TextEditingController();
TextEditingController passController = TextEditingController();
GlobalKey<FormState> formkey_email = GlobalKey<FormState>();
GlobalKey<FormState> formkey_pass = GlobalKey<FormState>();
var user_name;

class _LoginState extends State<Login> {
  var login_loading = false;
  var tokens;
  late Timer timer;

  bool _isObscure = true;
  void initState() {
    super.initState();
    time();
  }

  Future time() async {
    SharedPreferences token = await SharedPreferences.getInstance();
    print("cccccccccccccccccccccccccccccccccccccccccc");
    print(token.getString("token"));
    setState(() {
      tokens = token.getString('token').toString();
      print(tokens);
    });

    if (tokens == "null") {
      Get.toNamed("/login");
    } else if (tokens != null) {
      timer =
          Timer(const Duration(milliseconds: 12), () => Get.toNamed("/home"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 216, 94, 57),
        body: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              height: size.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    bottom: 20.0,
                    child: Column(
                      children: <Widget>[
                        buildCard(size),
                        buildFooter(size),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildCard(Size size) {
    return Container(
      alignment: Alignment.center,
      width: size.width * 0.9,
      height: size.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo & text
          logo(size.height / 8, size.height / 8),
          SizedBox(
            height: size.height * 0.03,
          ),
          richText(24),
          SizedBox(
            height: size.height * 0.05,
          ),

          //email & password textField
          emailTextField(size),
          SizedBox(
            height: size.height * 0.02,
          ),
          passwordTextField(size),
          SizedBox(
            height: size.height * 0.03,
          ),

          //sign in button
          LogInButton(size),
        ],
      ),
    );
  }

  Widget buildFooter(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          height: size.height * 0.04,
        ),
        SizedBox(
          width: size.width * 0.6,
          height: 44.0,
        ),
      ],
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/profile.png',
      height: height_,
      width: width_,
    );
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: Color.fromARGB(255, 216, 94, 57),
          letterSpacing: 2.000000061035156,
        ),
        children: const [
          TextSpan(
            text: 'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'PAGE',
            style: TextStyle(
              color: Color(0xFF2B3467),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget emailTextField(Size size) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          height: size.height / 12,
          child: Form(
            key: formkey_email,
            child: TextFormField(
              controller: emailcontroller,
              style: GoogleFonts.inter(
                fontSize: 18.0,
                color: const Color(0xFF151624),
              ),
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
              cursorColor: const Color(0xFF151624),
              decoration: InputDecoration(
                counterText: "",
                hintText: 'Enter Email id',
                hintStyle: GoogleFonts.inter(
                  fontSize: 16.0,
                  color: const Color(0xFF151624).withOpacity(0.5),
                ),
                filled: true,
                fillColor: emailcontroller.text.isEmpty
                    ? const Color.fromRGBO(248, 247, 251, 1)
                    : Colors.transparent,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: emailcontroller.text.isEmpty
                          ? Colors.transparent
                          : const Color(0xFF2B3467),
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: Color(0xFF2B3467),
                    )),
                prefixIcon: Icon(
                  Icons.phone,
                  color: emailcontroller.text.isEmpty
                      ? const Color(0xFF151624).withOpacity(0.5)
                      : const Color(0xFF2B3467),
                  size: 16,
                ),
                suffix: Container(
                  alignment: Alignment.center,
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: const Color(0xFF2B3467),
                  ),
                  child: emailcontroller.text.isEmpty
                      ? const Center()
                      : const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 13,
                        ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget passwordTextField(Size size) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
            height: size.height / 12,
            child: Form(
                key: formkey_pass,
                child: TextFormField(
                  controller: passController,
                  style: GoogleFonts.inter(
                    fontSize: 16.0,
                    color: const Color(0xFF151624),
                  ),
                  cursorColor: const Color(0xFF151624),
                  obscureText: _isObscure,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    focusedBorder:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                          color: Color(0xFF2B3467),
                        ));
                    if (value == null || value.isEmpty) {
                      return 'Please enter Password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16.0,
                      color: const Color(0xFF151624).withOpacity(0.5),
                    ),
                    filled: true,
                    fillColor: passController.text.isEmpty
                        ? const Color.fromRGBO(248, 247, 251, 1)
                        : Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          color: passController.text.isEmpty
                              ? Colors.transparent
                              : Color(0xFF2B3467),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                          color: Color(0xFF2B3467),
                        )),
                    prefixIcon: Icon(
                      Icons.lock_outline_rounded,
                      color: passController.text.isEmpty
                          ? const Color(0xFF151624).withOpacity(0.5)
                          : Color(0xFF2B3467),
                      size: 16,
                    ),
                    suffix: Container(
                      alignment: Alignment.center,
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: const Color(0xFF2B3467),
                      ),
                      child: Center(
                        child: IconButton(
                            padding: EdgeInsets.only(bottom: 0),
                            icon: Icon(
                              _isObscure
                                  ? (Icons.visibility)
                                  : (Icons.visibility_off),
                              color: Colors.white,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                      ),
                    ),
                  ),
                ))));
  }

  Widget LogInButton(Size size) {
    return Container(
      height: size.height / 13,
      width: size.width * 0.7,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            login_loading = true;
          });

          if (formkey_email.currentState!.validate() &&
              (formkey_pass.currentState!.validate())) {
            ;
            loginup(emailcontroller.text, passController.text);
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
          primary: Color(0xFF2B3467),
          shape: StadiumBorder(),
        ),
        child: (login_loading)
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.5,
                ))
            : const Text(
                "Log In",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }

// if (formkey_email.currentState!.validate() && (formkey_pass.currentState!.validate()));

  loginup(emailid, password) async {
    print('object');
    var response = await http.post(Uri.parse(
        "${dotenv.env['API_URL']}/api/method/thirvu_event.custom.py.api.login?email=${emailid}&password=${password}"));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      if (json.decode(response.body)['message'].toString() ==
          "Logined Sucessfully") {
        user_name = json.decode(response.body)['full_name'];
        print(user_name);
        setState(() {
          login_loading = false;
        });
        SharedPreferences token = await SharedPreferences.getInstance();

        token.setString(
            'full_name', json.decode(response.body)['full_name'] ?? "");
        token.setString('token', json.decode(response.body)['token'] ?? "");
        print(token.getString("full_name"));
        var user_email = token.getString("full_name");

        Get.toNamed('/home');

        Fluttertoast.showToast(
            msg: (json.decode(response.body)['message']),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Color.fromARGB(255, 15, 194, 62),
            textColor: Colors.white,
            fontSize: 15.0);
      } else {
        Fluttertoast.showToast(
            msg: (json.decode(response.body)['message']),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Color.fromARGB(255, 182, 21, 43),
            textColor: Colors.white,
            fontSize: 15.0);
        setState(() {
          login_loading = false;
        });
      }
    } else if (response.statusCode == 500) {
      setState(() {
        login_loading = false;
      });
      Fluttertoast.showToast(
          msg: (json.decode(response.body)['message']),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(255, 234, 10, 10),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
