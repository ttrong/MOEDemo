import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moe_cfims/application/login_form/login_form_bloc.dart';
import 'package:moe_cfims/injection.dart';
import 'package:moe_cfims/presentation/Screen/Login/login_form.dart';
import 'package:moe_cfims/presentation/core/colors.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.appBackground,
      ),
      body: BlocProvider(
        create: (context) => getIt<LoginFormBloc>(),
        child: LoginForm(),
      ),
    );
  }
}
