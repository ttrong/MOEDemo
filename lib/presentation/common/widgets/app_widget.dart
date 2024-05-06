import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moe_cfims/application/auth/auth_status_bloc.dart';
// import 'package:moe_cfims/application/channels/current/current_channel_cubit.dart';
// import 'package:moe_cfims/application/dms/current/current_dm_cubit.dart';
// import 'package:moe_cfims/application/dms/dm_list/dm_list_cubit.dart';
// import 'package:moe_cfims/application/guilds/current/current_guild_cubit.dart';
// import 'package:moe_cfims/application/guilds/guild_list/guild_list_cubit.dart';
// import 'package:moe_cfims/application/notifications/dm_notifications_cubit.dart';
// import 'package:moe_cfims/application/notifications/notifications_cubit.dart';
// import 'package:moe_cfims/application/notifications/request_notifications_cubit.dart';
import 'package:moe_cfims/injection.dart';
import 'package:moe_cfims/presentation/Screen/splash/splash_page.dart';
import 'package:moe_cfims/presentation/core/app_router.dart';
import 'package:moe_cfims/presentation/core/app_theme.dart';
// import 'package:moe_cfims/presentation/core/user_socket_hook.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthStatusBloc>()
            ..add(
              const AuthStatusEvent.authCheckRequested(),
            ),
        ),
        // BlocProvider(create: (context) => getIt<NotificationsCubit>()),
        // BlocProvider(create: (context) => getIt<RequestNotificationsCubit>()),
        // BlocProvider(create: (context) => getIt<DMNotificationsCubit>()),
        // BlocProvider(create: (context) => getIt<CurrentDMCubit>()),
        // BlocProvider(create: (context) => getIt<GuildListCubit>()),
        // BlocProvider(create: (context) => getIt<CurrentChannelCubit>()),
        // BlocProvider(create: (context) => getIt<CurrentGuildCubit>()),
        // BlocProvider(create: (context) => getIt<DMListCubit>()),
      ],
      child: _App(),
    );
  }
}

class _App extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // if (doesCurrentUserExist()) {
    //   use(UserSocketHook(context));
    // }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOE CFIMS',
      theme: appTheme,
      initialRoute: '/',
      onGenerateRoute: _appRouter.onGenerateRoute,
      home: SplashPage(),
    );
  }
}
