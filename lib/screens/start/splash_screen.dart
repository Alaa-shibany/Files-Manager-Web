import 'package:files_manager/core/functions/statics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/splash/splash_cubit.dart';
import 'package:files_manager/theme/color.dart';

import '../../core/animation/dialogs/dialogs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SplashCubit>();
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.dark,
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoginState) {
            if (cubit.checkInternetCounter >= 0) {
              print('hello 3');

              Navigator.pop(context);
            }
            print('hello 1');
            state.isLogIn == true
                ? Navigator.of(context)
                    .pushReplacementNamed('/navigation_screen')
                : Navigator.of(context).pushReplacementNamed('/login_screen');
          } else if (state is SplashNoInternetConnection) {
            print('hello 2');
            if (cubit.checkInternetCounter == 0) {
              internetDialog(context: context, mediaQuery: mediaQuery);
            }
            cubit.checkConnection(context: context);
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: mediaQuery.height,
            width: mediaQuery.width,
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.05,
                  child: Image(
                    image: const AssetImage('assets/images/background.png'),
                    height: mediaQuery.height,
                    width: mediaQuery.width,
                    fit: BoxFit.contain,
                    // filterQuality: FilterQuality.medium,
                  ),
                ),
                Center(
                        child: Image(
                  image: const AssetImage('assets/images/logo.png'),
                  height: Statics.isPlatformDesktop
                      ? mediaQuery.height / 2
                      : mediaQuery.height / 3,
                  // width: mediaQuery.width,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.medium,
                ))
                    .animate()
                    .fade(duration: const Duration(milliseconds: 100))
                    .slideY(
                        begin: 1,
                        end: 0,
                        duration: Duration(microseconds: 500)),
              ],
            ),
          );
        },
      ),
    );
  }
}
