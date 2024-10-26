import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final cubit = context.read<NavigationCubit>();
    return Scaffold(
      bottomNavigationBar: Container(
        // margin: EdgeInsets.only(
        //   right: mediaQuery.width / 30,
        //   left: mediaQuery.width / 30,
        //   bottom: mediaQuery.height / 70,
        // ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          // borderRadius: const BorderRadius.all(
          //   Radius.circular(60),
          // ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 203, 203, 203).withOpacity(0.1),
              spreadRadius: 1,
              // blurRadius: 5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<NavigationCubit, NavigationState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    // borderRadius: const BorderRadius.all(Radius.circular(80)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, -10), // changes position of shadow
                      ),
                    ],
                  ),
                  child: NavigationBar(
                    destinations: [
                      NavigationDestination(
                        icon: Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                          size: mediaQuery.width / 15,
                        ),
                        label: S.of(context).home,
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: mediaQuery.width / 15,
                        ),
                        label: S.of(context).notifications,
                      ),
                      // NavigationDestination(
                      //   icon: Icon(
                      //     Icons.favorite,
                      //     color: Colors.white,
                      //     size: mediaQuery.width / 15,
                      //   ),
                      //   label: S.of(context).favorite,
                      // ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: mediaQuery.width / 15,
                        ),
                        label: S.of(context).settings,
                      ),
                    ],
                    selectedIndex: cubit.currentScreenIndex,
                    onDestinationSelected: cubit.changeScreen,
                    indicatorColor: Colors.transparent,
                    height: mediaQuery.height / 15,
                    labelBehavior:
                        NavigationDestinationLabelBehavior.onlyShowSelected,
                    surfaceTintColor: Colors.amber,
                    animationDuration: const Duration(milliseconds: 100),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: cubit.controller,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        pageSnapping: true,
        allowImplicitScrolling: false,
        onPageChanged: null,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          cubit.screens.length,
          (index) {
            return cubit.screens[index];
          },
        ),
      ),
    );
  }
}
