import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
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
        title: Text(widget.title),
      ),
      body: DefaultTabController(
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
                  tabs: [
                    Tab(
                      text: "Today",
                    ),
                    Tab(
                      text: "Workddd",
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
                Container(
                  width: 200,
                  height: 200,
                  child: TabBarView(controller: _tabController, children: [
                    Container(
                      width: 10,
                      height: 10,
                      child: Text("dddddgdggfgddddddddd"),
                    ),
                    Container(
                        width: 10, height: 10, child: Text("dddddddddddddd")),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
