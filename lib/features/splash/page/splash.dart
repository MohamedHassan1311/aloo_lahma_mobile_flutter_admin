import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zurex_admin/app/core/app_state.dart';
import 'package:zurex_admin/app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zurex_admin/features/splash/repo/splash_repo.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/images.dart';
import '../../../data/config/di.dart';
import '../bloc/splash_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(repo: sl<SplashRepo>())..add(Click()),
      child: BlocBuilder<SplashBloc, AppState>(
        builder: (context, state) {
          return Scaffold(
              body: Stack(
            children: [
              Center(
                child: Image.asset(
                  Images.splash,
                  width: context.width,
                ).animate().then(delay: 200.ms).shimmer(),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 100,
                  width: context.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                        Colors.white,
                        Color(0xffc2d6e3),
                      ])),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 10,
                child: Image.asset(
                  Images.motorSplash,
                  width: context.width * .85,
                )
                    .animate()
                    .slideX(begin: 1.0, end: 0.0, duration: 1200.ms)
                    .then(delay: 200.ms)
                    .shimmer(),
              ),
            ],
          ));
        },
      ),
    );
  }
}
