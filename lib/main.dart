import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/home_layout.dart';
import 'package:social/modules/login/cubit/cubit.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/modules/register/cubit/cubit.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/network/cache_helper.dart';
import 'package:social/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  Widget homeScreen;
  if (uId != null) {
    homeScreen = const HomeLayout();
  } else {
    homeScreen = const LoginScreen();
  }
  runApp(MyApp(homeScreen: homeScreen));
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;

  const MyApp({super.key, required this.homeScreen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
        BlocProvider(create: (context) => SocialLoginCubit()),
        BlocProvider(create: (context) => SocialRegisterCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: homeScreen,
      ),
    );
  }
}
