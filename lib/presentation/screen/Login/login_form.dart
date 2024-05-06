import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moe_cfims/application/login_form/login_form_bloc.dart';
import 'package:moe_cfims/presentation/core/restart_widget.dart';
import 'package:moe_cfims/presentation/core/colors.dart';
import 'package:moe_cfims/presentation/common/untils/flushbar_creator.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext _) {
    return BlocConsumer<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold((failure) {
                  showError(
                      message: failure.maybeMap(
                    invalidCredentials: (_) => "Invalid Credentials",
                    orElse: () => "Server Error. Try again later.",
                  )).show(context);
                }, (_) {
                  RestartWidget.restartApp(context);
                }));
      },
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bulb.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          // margin: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "MOE CFIMS",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Powering Smart and Sustainable Facilities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 150,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email *'),
                  autocorrect: false,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<LoginFormBloc>().add(LoginFormEvent.emailChanged(value)),
                  validator: (_) => context.read<LoginFormBloc>().state.emailAddress.value.fold((l) => l.maybeMap(invalidEmail: (_) => 'Invalid Email', orElse: () => null), (_) => null),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.themeBlue,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          context.read<LoginFormBloc>().add(const LoginFormEvent.loginPressed());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer()
              ],
            ),
          ),
        );
      },
    );
  }
}
