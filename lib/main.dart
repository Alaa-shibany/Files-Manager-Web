import 'package:files_manager/core/notification/notification_web.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/core/functions/statics.dart';
import 'package:files_manager/cubits/theme_cubit/app_theme_cubit.dart';
import 'package:files_manager/models/themestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../cubits/all_boards_cubit/all_boards_cubit.dart';
import '../cubits/board_favorite_cubit/board_favorite_cubit.dart';
import '../cubits/locale_cubit/locale_cubit.dart';
import '../generated/l10n.dart';
import '../simple_bloc_observer.dart';
import '../theme/theme.dart';
import 'cubits/file_report_cubit/file_report_cubit.dart';
import 'cubits/user_report_cubit/user_report_cubit.dart';
import 'routes/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashNetwork.cashInitialization();

  await Hive.initFlutter();
  await Hive.openBox('main');
  final notificationService = NotificationService();
  await notificationService.listenNotifications();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = SimpleBlocObserver();
  runApp(
    Phoenix(child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit()..initializeLocale(),
        ),
        BlocProvider<AppThemeCubit>(
          create: (context) => AppThemeCubit(),
        ),
        BlocProvider<AllBoardsCubit>(
          create: (context) => AllBoardsCubit(),
        ),
        // BlocProvider<AllBoardsCubit>(
        //   create: (context) => AllBoardsCubit()..initState(context: context),
        // ),
        BlocProvider<BoardFavoriteCubit>(
          create: (context) => BoardFavoriteCubit(),
        ),
        BlocProvider(
            create: (context) => FileReportCubit()..loadFileReportData()),
        BlocProvider(
            create: (context) => UserReportCubit()..loadUserReportData()),
      ],
      child: BlocConsumer<LocaleCubit, LocaleState>(
        listener: (context, state) {
          if (state is ChangeLocaleState) {}
        },
        builder: (context, state) {
          final localCubit = context.read<LocaleCubit>();
          final mediaQuery = MediaQuery.of(context).size;
          Statics.isPlatformDesktop = mediaQuery.width > 700;
          return BlocBuilder<AppThemeCubit, AppThemeState>(
            builder: (themeContext, themeState) {
             return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Files Manager App',
                initialRoute: '/',
                routes: routes,
                theme: themeState is AppThemeDark
                    ? DarkThemeData
                    : LightThemeData,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: localCubit.locale,
                navigatorKey: navigatorKey,
              );
            },
          );
        },
      ),
    );
  }
}
