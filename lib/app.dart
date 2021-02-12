import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:smartgreenhouse_app/app_router.dart';
import 'package:smartgreenhouse_app/authentication/authentication.dart';
import 'package:smartgreenhouse_app/home/home.dart';
import 'package:smartgreenhouse_app/login/login.dart';
import 'package:smartgreenhouse_app/menu/menu.dart';
import 'package:smartgreenhouse_app/particles/particles.dart';
import 'package:smartgreenhouse_app/rules/rules.dart';
import 'package:smartgreenhouse_app/sensor_values/sensor_values.dart';
import 'package:smartgreenhouse_app/splash/splash.dart';
import 'package:smartgreenhouse_app/theme.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.greenhouseRepository,
  })  : assert(authenticationRepository != null),
        assert(greenhouseRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final GreenhouseRepository greenhouseRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: greenhouseRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => ParticlesCubit(
              greenhouseRepository: greenhouseRepository,
            ),
          ),
          BlocProvider(
            create: (context) => SensorValuesCubit(
              greenhouseRepository: greenhouseRepository,
            ),
          ),
          BlocProvider(
            create: (context) => RulesCubit(
              greenhouseRepository: greenhouseRepository,
            ),
          ),
          BlocProvider(
            create: (context) => MenuCubit(),
          ),
        ],
        child: BlocListener<ParticlesCubit, ParticlesState>(
          listener: (context, state) {
            if (state is ParticlesLoadSuccess) {
              context.bloc<SensorValuesCubit>().load(state.particles);
              context.bloc<RulesCubit>().load(state.particles);
            }
          },
          child: AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final _router = AppRouter();
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GreenHouseTheme.light,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                context.bloc<ParticlesCubit>().syncParticleCloud();
                _navigatorKey.currentState.pushNamedAndRemoveUntil<void>(AppRoutes.home, (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigatorKey.currentState.pushNamedAndRemoveUntil<void>(AppRoutes.login, (route) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      initialRoute: AppRoutes.splash,
      onGenerateRoute: _router.onGenerateRoute,
    );
  }
}
