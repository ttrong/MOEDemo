import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moe_cfims/application/auth/auth_status_bloc.dart';
import 'package:moe_cfims/presentation/Screen/Login/login_screen.dart';
import 'package:moe_cfims/presentation/core/colors.dart';

class SplashPage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthStatusBloc, AuthStatusState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) {
            // context.read<GuildListCubit>().getGuilds();
            // context.read<DMListCubit>().getUserDMs();
            // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
          unauthenticated: (_) {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
        );
      },
      child: const Scaffold(
        backgroundColor: ThemeColors.appBackground,
        body: Center(
          child: Image(
            height: 100,
            image: AssetImage('assets/logo.png'),
          ),
        ),
      ),
    );
  }
}
