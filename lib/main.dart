import 'dart:io';

import 'package:beautiful_destinations/app.dart';
import 'package:beautiful_destinations/simple_bloc_observer.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

import 'firebase_options.dart';

late SharedPreferences sharesPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharesPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
      name: "tourism", options: DefaultFirebaseOptions.currentPlatform);

  if (Platform.isLinux || Platform.isWindows) {
    DartVLC.initialize();
  }

  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}
