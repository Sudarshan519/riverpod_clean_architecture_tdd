// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:khalti_task/features/home/presentation/screens/home_screen.dart';

import 'package:khalti_task/features/splash/presentation/screens/splash_screen.dart';
part 'app_route.gr.dart';
// @MaterialAutoRouter(
//   replaceInRouteName: 'Page,Route',
//   routes: [
//     MaterialRoute(page: SplashScreen, initial: true),
//     MaterialRoute(page: LoginScreen, path: LoginScreen.routeName),
//     MaterialRoute(page: homeScreen, path: homeScreen.routeName),
//   ],
// )

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
// @override
// replaceInRouteName

  @override
  RouteType get defaultRouteType =>
      const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
      ];
}
