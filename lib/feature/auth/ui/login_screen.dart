import 'package:client_it/app/ui/components/app_text_button.dart';
import 'package:client_it/app/ui/components/app_text_field.dart';
import 'package:client_it/app/ui/components/container_example.dart';
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:client_it/feature/auth/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginScreen'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 50,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    controller: controllerLogin,
                    labelText: 'login',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextField(
                    obscureText: true,
                    controller: controllerPassword,
                    labelText: 'password',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        _onTapToSignIn(context.read<AuthCubit>());
                      }
                    },
                    textButton: 'sign in',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextButton(
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ));
                    },
                    textButton: 'sign up',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ContainerExample(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapToSignIn(AuthCubit authCubit) => authCubit.signIn(
        username: controllerLogin.text,
        password: controllerPassword.text,
      );
}
