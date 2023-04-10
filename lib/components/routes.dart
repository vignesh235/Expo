import 'package:get/get.dart';

import '../Screens/Homepage.dart';
import '../Screens/Homescreen.dart';
import '../Screens/loginpage.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => Login(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/home',
        page: () => const homescreen(),
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
