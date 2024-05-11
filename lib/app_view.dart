import 'package:beautiful_destinations/app/authentication/page/auth_code.dart';
import 'package:beautiful_destinations/app/authentication/page/signin.dart';
import 'package:beautiful_destinations/app/authentication/view/auth_code.dart';
import 'package:beautiful_destinations/app/book/accomodation.dart';
import 'package:beautiful_destinations/app/book/detail.dart';
import 'package:beautiful_destinations/app/home/home.dart';
import 'package:beautiful_destinations/app/home/search/filter.dart';
import 'package:beautiful_destinations/app/landing/landing.dart';
import 'package:beautiful_destinations/app/navigation/menu.dart';
import 'package:beautiful_destinations/app/navigation/settings/bloc/settings_bloc.dart';
import 'package:beautiful_destinations/app/notification/notification.dart';
import 'package:beautiful_destinations/app/tiktok/tiktok_video_view.dart';
import 'package:beautiful_destinations/auth_screen/welcome_screen.dart';
import 'package:beautiful_destinations/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:beautiful_destinations/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:beautiful_destinations/main.dart';
import 'package:beautiful_destinations/repositories/authentication/repository.dart';
import 'package:beautiful_destinations/repositories/models/enums/brightness.dart';
import 'package:beautiful_destinations/repositories/place/place_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  ThemeData get darkBrightness => ThemeData(
        fontFamily: "manrope",
        primarySwatch: const MaterialColor(
          0xFFffab40, // primaryColor
          <int, Color>{
            50: Color(0xFFFFF5E8),
            100: Color(0xFFFFE6C6),
            200: Color(0xFFFFD5A0),
            300: Color(0xFFFFC479),
            400: Color(0xFFFFB85D),
            500: Color(0xFFffab40), // primaryColor
            600: Color(0xFFFFA43A),
            700: Color(0xFFFF9A32),
            800: Color(0xFFFF912A),
            900: Color(0xFFFF801C),
          },
        ),
      );

  ThemeData get lightBrightness => ThemeData(
        fontFamily: "manrope",
        primarySwatch: const MaterialColor(
          0xFFffab40, // primaryColor
          <int, Color>{
            50: Color(0xFFFFF5E8),
            100: Color(0xFFFFE6C6),
            200: Color(0xFFFFD5A0),
            300: Color(0xFFFFC479),
            400: Color(0xFFFFB85D),
            500: Color(0xFFffab40), // primaryColor
            600: Color(0xFFFFA43A),
            700: Color(0xFFFF9A32),
            800: Color(0xFFFF912A),
            900: Color(0xFFFF801C),
          },
        ),
      );

  ThemeData getBrightness(MoreBrightness moreBrightness) {
    final brightness = moreBrightness == MoreBrightness.systemDefault
        // ignore: deprecated_member_use
        ? MediaQueryData.fromView(WidgetsBinding.instance.window)
            .platformBrightness
        : Brightness.values.byName(moreBrightness.name);

    if (brightness == Brightness.dark) return darkBrightness;
    return lightBrightness;
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthenticationRepository()),
        RepositoryProvider(
          create: (_) => PlaceRepository(FirebaseFirestore.instance),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (BuildContext providerContext) => SettingsBloc(
              sharedPreferences: sharesPreferences,
              authenticationRepository:
                  providerContext.read<AuthenticationRepository>(),
            ),
          ),
        ],
        child: BlocConsumer<SettingsBloc, SettingsState>(
          buildWhen: (previous, current) =>
              previous.authStatus != current.authStatus,
          listener: (context, state) {
            // if(state.authStatus == AuthenticationStatus.unauthenticated) {
            //   Naviga
            // }
          },
          builder: (BuildContext context, state) => MaterialApp(
            title: 'Tourism',
            debugShowCheckedModeBanner: false,
            // locale: state.locale,
            routes: {
              LandingView.routeName: (_) => const LandingView(),
              SingInPage.routeName: (_) => const SingInPage(),
              AuthCodePage.routeName: (_) => const AuthCodeView(),
              MainView.routeName: (_) => const MainView(),
              NotificationView.routeName: (_) => const NotificationView(),
              NavigationMenu.routeName: (_) => const NavigationMenu(),
              FilterView.routeName: (_) => const FilterView(),
              DetailView.routeName: (_) => const DetailView(),
              HotelDetailView.routeName: (_) => const HotelDetailView(),
              TiktokVideoView.routeName: (_) => const TiktokVideoView(),
            },
            theme: getBrightness(state.brightness),
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state.status == AuthenticationStatus.authenticated) {
                  return BlocProvider(
                    create: (context) => SignInBloc(
                        userRepository:
                            context.read<AuthenticationBloc>().userRepository),
                    child: const MainView(),
                  );
                } else {
                  return const WelcomeScreen();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
