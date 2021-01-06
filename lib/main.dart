import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartgreenhouse_app/app.dart';
import 'package:smartgreenhouse_app/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter('v01');
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();

  final authenticationRepository = AuthenticationRepository();
  final greenhouseRepository = GreenhouseRepository(authenticationRepository: authenticationRepository);
  
  runApp(App(
    authenticationRepository: authenticationRepository,
    greenhouseRepository: greenhouseRepository,
  ));
}
