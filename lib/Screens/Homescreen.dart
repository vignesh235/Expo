import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../components/listview.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Column(
            children: const [
              Text(
                '  Hello there' " 👋🏼",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              Text('Vignesh'),
            ],
          ),
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
                              child: myListView(15),
                            )),
                        SizedBox(
                            width: 10,
                            height: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: myListView(15),
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
}
