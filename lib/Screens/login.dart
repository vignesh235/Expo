// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'package:connectivity/connectivity.dart';

// import 'Homescreen.dart';

// class LoginApp extends StatefulWidget {
//   @override
//   State<LoginApp> createState() => _LoginAppState();
// }

// class _LoginAppState extends State<LoginApp> {
//   void initState() {
//     Future(() async {
//       // await Future.delayed(Duration(milliseconds: 150));
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       PackageInfo packageInfo = await PackageInfo.fromPlatform();
//       setState(() {
//         // currentIndex = 0;
//         // version = packageInfo.version;
//         // profile_branch = prefs.getString('branch');
//         // user_name = prefs.getString('user_name');
//         // user_email = prefs.getString("email");
//       });
//     });
//     checkconnection();
//   }

//   @override
//   bool _isObscure = true;
//   bool isLoading = false;
//   final formKey = GlobalKey<FormState>();

//   var emailcontroller = TextEditingController();

//   var passwordcontroller = TextEditingController();

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(color: Color(0xff19183e)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 25,
//               ),
//               Image.asset('assets/profile.png'),
//               SizedBox(
//                 height: 25,
//               ),
//               Container(
//                 width: 350,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(15)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Text(
//                       "Login",
//                       style: GoogleFonts.poppins(
//                         textStyle: TextStyle(
//                           letterSpacing: .5,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Container(
//                       child: Form(
//                           key: formKey,
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: 300,
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.12,
//                                 child: TextFormField(
//                                   controller: emailcontroller,
//                                   decoration: InputDecoration(
//                                       suffix: Icon(
//                                         FontAwesomeIcons.envelope,
//                                         color: Color.fromARGB(255, 15, 15, 15),
//                                       ),
//                                       labelText: "Email",
//                                       isDense: true,
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(8)),
//                                       )),
//                                   validator: (value) {
//                                     if (value!.trim().isEmpty ||
//                                         !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                             .hasMatch(value)) {
//                                       setState(() {
//                                         isLoading = false;
//                                       });
//                                       return "Invalid email";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                               Container(
//                                 width: 300,
//                                 height: 80,
//                                 child: TextFormField(
//                                     controller: passwordcontroller,
//                                     obscureText: _isObscure,
//                                     decoration: InputDecoration(
//                                         labelText: "Password",
//                                         suffixIcon: IconButton(
//                                           icon: Icon(
//                                             _isObscure
//                                                 ? Icons.visibility
//                                                 : Icons.visibility_off,
//                                           ),
//                                           onPressed: () {
//                                             setState(() {
//                                               _isObscure = !_isObscure;
//                                             });
//                                           },
//                                         ),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(8)),
//                                         )),
//                                     validator: (value) {
//                                       if (value!.trim().isEmpty ||
//                                           !RegExp(r'.{8,}$').hasMatch(value)) {
//                                         setState(() {
//                                           isLoading = false;
//                                         });
//                                         return "Invalid password";
//                                       } else {
//                                         return null;
//                                       }
//                                     }),
//                               ),
//                             ],
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 35,
//               ),
//               Container(
//                   height: 50,
//                   width: 350,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                       gradient: LinearGradient(colors: [
//                         Color(0xFF8A2387),
//                         Color(0xFFE94057),
//                         Color(0xFFF27121),
//                       ])),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       setState(() {
//                         isLoading = true;
//                       });

//                       if (formKey.currentState!.validate()) {
//                         login(emailcontroller.text, passwordcontroller.text);
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //       builder: (context) => bottomnavigation()),
//                         // );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent),
//                     child: (isLoading)
//                         ? SizedBox(
//                             width: 16,
//                             height: 16,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 1.5,
//                             ))
//                         : Text(
//                             'Login',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future login(email, password) async {
//     if (passwordcontroller.text.isNotEmpty || emailcontroller.text.isNotEmpty) {
//       var response = await http.post(Uri.parse(
//           "https://sstlive.thirvusoft.co.in/api/method/expo.expo.custom.api.login_1?email=${email}&password=${password}"));
//       if (response.statusCode == 200) {
//         setState(() {
//           isLoading = false;
//         });
//         SharedPreferences prefs = await SharedPreferences.getInstance();

//         prefs.setString('full_name', json.decode(response.body)['full_name']);

//         // Branch.text = prefs.getString('branch')!;
//         prefs.setString("email", emailcontroller.text);
//         prefs.setString("password", passwordcontroller.text);
//         emailcontroller.text = (prefs.getString("email").toString() ?? "");

//         // passwordcontroller.text =
//         //     (prefs.getString("password").toString() ?? "");

//         prefs.commit();

//         var emails = prefs.getString('branch');
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => homescreen(),
//           ),
//           (route) => false,
//         );
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(json.decode(response.body)['message']),
//           backgroundColor: Colors.green,
//         ));
//       }
//     }
//   }

//   checkconnection() async {
//     var connection = await Connectivity().checkConnectivity();
//     if (connection == ConnectivityResult.none) {
//       return ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('No Internet')));
//     }
//     ;
//   }
// }
