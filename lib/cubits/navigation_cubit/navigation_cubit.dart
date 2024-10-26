import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/add_board_cubit/add_board_cubit.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/auth/delete_account/delete_account_cubit.dart';
import 'package:files_manager/cubits/board_favorite_cubit/board_favorite_cubit.dart';
import 'package:files_manager/cubits/leave_from_board_cubit/leave_from_board_cubit.dart';
import 'package:files_manager/cubits/notification_cubit/notification_cubit.dart';
import 'package:files_manager/screens/favorite_screen/favorite_screen.dart';
import 'package:files_manager/screens/home/board_screen.dart';
import 'package:files_manager/screens/notifications/notification_screen.dart';
import 'package:files_manager/screens/settings/settings_screen.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  final List screens = [
    //==== Board Screen =====//
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllBoardsCubit()..initState(context: context),
        ),
        BlocProvider(
          create: (context) => LeaveFromBoardCubit(),
        ),
        BlocProvider(
          create: (context) => AddBoardCubit(),
        ),
      ],
      child: const BoardScreen(),
    ),
    //==== Notification Screen =====//
    BlocProvider(
      create: (context) => NotificationCubit()..getData(context: context),
      child: const NotificationScreen(),
    ),
    //==== Favorite Screen =====//
    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) =>
    //           BoardFavoriteCubit()..initState(context: context),
    //     ),
    //     BlocProvider(
    //       create: (context) => LeaveFromBoardCubit(),
    //     ),
    //     BlocProvider(
    //       create: (context) => AddBoardCubit(),
    //     ),
    //   ],
    //   child: const FavoriteScreen(),
    // ),
    //==== Settings Screen =====//
    BlocProvider(
      create: (context) => DeleteAccountCubit(),
      child: const SettingsScreen(),
    ),
  ];
  PageController controller = PageController(initialPage: 0);

  int currentScreenIndex = 0;

  void initState(int startPage) {
    controller = PageController(initialPage: startPage);
    currentScreenIndex = startPage;
  }

  void changeScreen(int newScreenIndex) {
    currentScreenIndex = newScreenIndex;

    controller.animateToPage(newScreenIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCirc);
    emit(NavigationChangeScreenState());
  }
}
