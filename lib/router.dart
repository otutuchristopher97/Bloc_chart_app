import 'package:auto_route/annotations.dart';
import 'package:libary_messaging_system/screens/add_broadcast/add_broadcast_screen.dart';
import 'package:libary_messaging_system/screens/chat/chat_screen.dart';
import 'package:libary_messaging_system/screens/home_screen/home_screen.dart';
import 'package:libary_messaging_system/screens/splash_screen.dart';
import 'package:libary_messaging_system/screens/authentication/login/login_screen.dart';
import 'package:libary_messaging_system/screens/general_broadcast/general_broadcast_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen),
    AutoRoute(page: ChatScreen),
    AutoRoute(page: LoginScreen),
    AutoRoute(page: AddBroadcastScreen),
    AutoRoute(page: GeneralBroadcastScreen),
    AutoRoute(page: SplashScreen, initial: true),
  ],
)
class $AppRouter {}
