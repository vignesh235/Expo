import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../color.dart';
import '../components/listview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'Homepage.dart';

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
            Text(
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
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.png'),
              ),
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

    // var user_name;
    // SharedPreferences token = await SharedPreferences.getInstance();
    // user_name = token.getString('full_name').toString();

    // print(user_name);
    SharedPreferences token = await SharedPreferences.getInstance();

    var response = await http.post(
        Uri.parse(
            "https://sstlive.thirvusoft.co.in/api/method/expo.expo.custom.api.event_list?user=${token.getString('full_name').toString()}"),
        headers: {"Authorization": "token 1599e6dcec498c6:ae5a9f65dd361e8"});

    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        for (var i = 0; i < json.decode(response.body)['today'].length; i++) {
          event.add((json.decode(response.body)['today'][i]));
        }
        for (var i = 0;
            i < json.decode(response.body)['upcoming'].length;
            i++) {
          event_upcoming.add((json.decode(response.body)['upcoming'][i]));
        }
        print(event);
        print(event_upcoming);
      });
    }
    ;
  }
}
