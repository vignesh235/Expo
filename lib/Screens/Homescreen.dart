import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../color.dart';
import '../components/listview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'Homepage.dart';
import 'loginpage.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    Future<void> user() async {
      SharedPreferences token = await SharedPreferences.getInstance();
      setState(() {
        username = token.getString('full_name').toString();
      });
    }

    pendinglist_();
    user();
    if (eventcode != "") {
      attdance(eventcode);
    }
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  String username = '';

  List event = [];
  List event_upcoming = [];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Column(children: [
            const Text(
              '  Hello there' " 👋🏼",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            ),
            Text(
              username,
            )
          ]),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () {
                    _delete(context);
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.png'),
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.green,
                      tabs: const [
                        Tab(
                          text: "Today",
                        ),
                        Tab(
                          text: "Upcoming",
                        ),
                      ],
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      indicator: RectangularIndicator(
                        bottomLeftRadius: 100,
                        bottomRightRadius: 100,
                        topLeftRadius: 100,
                        topRightRadius: 100,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: (MediaQuery.of(context).size.height) / 1.2,
                      child: TabBarView(controller: _tabController, children: [
                        SizedBox(
                            width: 10,
                            height: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ListView.builder(
                                  itemCount: event.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Homepage()),
                                              );
                                            },
                                            child: ListTile(
                                                leading: CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.iconcolor,
                                                    child: const Icon(
                                                      Icons.list,
                                                      color: Color(0xffe36c35),
                                                    )),
                                                trailing: const Icon(
                                                  PhosphorIcons.caret_right,
                                                ),
                                                subtitle: Text(
                                                    event[index]['starts_on']),
                                                title: Text(
                                                  event[index]['name'],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0XFF010418)),
                                                ))));
                                  }),
                            )),
                        SizedBox(
                            width: 10,
                            height: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListView.builder(
                                  itemCount: event_upcoming.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                        child: GestureDetector(
                                            // onTap: () {
                                            //   Get.toNamed('/second');
                                            // },
                                            child: ListTile(
                                                leading: CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.iconcolor,
                                                    child: const Icon(
                                                      Icons.list,
                                                      color: Color(0xffe36c35),
                                                    )),
                                                trailing: const Icon(
                                                  PhosphorIcons.caret_right,
                                                ),
                                                subtitle: Text(
                                                    event_upcoming[index]
                                                        ['starts_on']),
                                                title: Text(
                                                  event_upcoming[index]['name'],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0XFF010418)),
                                                ))));
                                  }),
                            ))
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        )));
  }

  Future pendinglist_() async {
    print('ddddddddddddddddddddddddddd');
    print('ddddddddddddddddddddddddddd');

    SharedPreferences token = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(
        "${dotenv.env['API_URL']}/api/method/thirvu_event.custom.py.api.event_list?user=${token.getString('full_name')}"));
    print(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        for (var i = 0; i < json.decode(response.body)['today'].length; i++) {
          setState(() {
            event.add((json.decode(response.body)['today'][i]));
          });
        }
        for (var i = 0;
            i < json.decode(response.body)['upcoming'].length;
            i++) {
          setState(() {
            event_upcoming.add((json.decode(response.body)['upcoming'][i]));
          });
        }
        print(event);
        print(event_upcoming);
      });
    }
    ;
  }

  Future attdance(eventcode) async {
    print("ooooooooooooooooooooooooooooooooooooo");
    print(eventcode);

    print(eventcode);
    SharedPreferences token = await SharedPreferences.getInstance();
    print(token.getString("token"));
    var name;
    eventcode = eventcode.replaceAll('"', '');

    name = token.getString('full_name').toString();

    var response = await http.post(
        Uri.parse(
            "${dotenv.env['API_URL']}/api/method/thirvu_event.custom.py.api.attendance?user=$name&name=$eventcode"),
        headers: {"Authorization": token.getString('token') ?? ""});
    print(response.body);
    print(
        "${dotenv.env['API_URL']}/api/method/thirvu_event.custom.py.api.attendance?user=${name}&name=${eventcode}");
    print(response.statusCode);
    if (response.statusCode == 200) {
      pendinglist_();
      setState(() {
        eventcode = "";
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.green,
      ));
    }
  }

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text("Please Confirm",
                style: TextStyle(
                    fontSize: 20, letterSpacing: .2, color: Color(0xFF2B3467))),
            content: const Text("Are you sure to logout?",
                style: TextStyle(
                    fontSize: 15, letterSpacing: .2, color: Color(0xFF2B3467))),
            actions: [
              // The "Yes" button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  final token = await SharedPreferences.getInstance();
                  print(token.getString("token"));
                  await token.clear();
                  // await token.remove('token');
                  print(token.getString("token"));
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
  }
}
