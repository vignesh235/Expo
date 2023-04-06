import 'package:get/get.dart';

import '../Screens/Homepage.dart';
import '../Screens/Homescreen.dart';

appRoutes() => [
      GetPage(
        name: '/home',
        page: () => homescreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/second',
        page: () => Homepage(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      // GetPage(
      //   name: '/third',
      //   page: () => ThirdPage(),
      //   middlewares: [MyMiddelware()],
      //   transition: Transition.leftToRightWithFade,
      //   transitionDuration: Duration(milliseconds: 500),
      // ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}
