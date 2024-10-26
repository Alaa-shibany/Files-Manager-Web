import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/notification/notification.dart';
import '../cubits/all_boards_cubit/all_boards_cubit.dart';
import '../cubits/board_favorite_cubit/board_favorite_cubit.dart';
import '../cubits/locale_cubit/locale_cubit.dart';
import '../generated/l10n.dart';
import '../simple_bloc_observer.dart';
import '../theme/theme.dart';
import 'core/shared/local_network.dart';
import 'routes/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashNetwork.cashInitialization();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD9PcdC2gBVEaGgIlfRNehM82HuaCcd1ls',
      appId: '1:222788676874:android:5bd0dae09af0000ed75ef3',
      messagingSenderId: '222788676874',
      projectId: 'projects2022-cf398',
    ),
  );
  await Hive.initFlutter();
  await Hive.openBox('main');
  final fcm = await FirebaseMessaging.instance.getToken();
  print('The fcm22 token is => $fcm');
  await FirebaseApi().initNotification();
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
        BlocProvider<AllBoardsCubit>(
          create: (context) => AllBoardsCubit(),
        ),
        // BlocProvider<AllBoardsCubit>(
        //   create: (context) => AllBoardsCubit()..initState(context: context),
        // ),
        BlocProvider<BoardFavoriteCubit>(
          create: (context) => BoardFavoriteCubit(),
        ),
      ],
      child: BlocConsumer<LocaleCubit, LocaleState>(
        listener: (context, state) {
          if (state is ChangeLocaleState) {}
        },
        builder: (context, state) {
          final localCubit = context.read<LocaleCubit>();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Files Manager App',
            initialRoute: '/',
            routes: routes,
            theme: themeData,
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
      ),
    );
  }
}
