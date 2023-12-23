import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:khalti_task/routes/app_route.dart';

///
@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  ///
  const SplashScreen({Key? key}) : super(key: key);

  ///
  static const String routeName = '/splashScreen';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final AppRouter appRouter = AppRouter();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      ///
      const route = HomeRoute();
      // ignore: use_build_context_synchronously
      unawaited(AutoRouter.of(context).pushAndPopUntil(
        route,
        predicate: (_) => false,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
          child: FlutterLogo(
        size: 60,
      )),
    );
  }
}
