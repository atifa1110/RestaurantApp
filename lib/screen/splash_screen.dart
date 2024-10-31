import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_size.dart';
import '../theme/app_theme.dart';
import '../theme/resource.dart';
import '../routing/app_routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  initState() {
    _navigateOtherScreen();
    super.initState();
  }

  void _navigateOtherScreen() {
    Future.delayed(const Duration(seconds: 3)).then(
          (_) => context.goNamed(Routes.home.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.scaffoldColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Resources.restrIcon,
              width: 100,
              height: 100,
            ),
            Gap.h12,
            Text(
              'Restaurant',
              style: AppThemes.headline1,
            ),
          ],
        ),
      ),
    );
  }
}