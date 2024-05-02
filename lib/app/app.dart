import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najot_pay/blocs/auth/auth_bloc.dart';
import 'package:najot_pay/blocs/bottom/bottom_bloc.dart';
import 'package:najot_pay/data/repositories/auth_repository.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/services/local_notification_service.dart';
import 'package:najot_pay/utils/styles/app_theme.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
              )..add(CheckAuthenticationEvent()),
            ),
            BlocProvider(create: (_) => BottomBloc())
          ],
          child: AdaptiveTheme(
            light: AppTheme.lightTheme,
            dark: AppTheme.darkTheme,
            initial: AdaptiveThemeMode.light,
            builder: (theme, darkTheme) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: theme,
                darkTheme: darkTheme,
                initialRoute: RouteNames.splashScreen,
                navigatorKey: navigatorKey,
                onGenerateRoute: AppRoutes.generateRoute,
              );
            },
          )),
    );
  }
}
