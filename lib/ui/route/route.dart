import 'package:get/route_manager.dart';

import '../views/home_screen.dart';
import '../views/intro_screen.dart';
import '../views/login_screen.dart';
import '../views/menu_screen.dart';
import '../views/reg_screen.dart';
import '../views/splash_screen.dart';

const String splash = '/splash';
const String intro = '/intro';
const String login = '/login';
const String reg = '/reg';
const String home = '/home';
const String menu = '/menu';
// const String err = '/err';

List<GetPage> getPages = [
  GetPage(name: splash, page: () => SplashScreen()),
  GetPage(name: intro, page: () => introScreen()),
  GetPage(name: login, page: () => LoginScreen()),
  GetPage(name: reg, page: () => RegScreen()),
  GetPage(name: home, page: () => Home()),
  GetPage(name: menu, page: () => Menu()),
  // GetPage(name: err, page: ()=>SplashScreen()),
];
