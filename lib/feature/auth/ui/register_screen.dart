import 'package:client_it/app/ui/components/app_text_button.dart';
import 'package:client_it/app/ui/components/app_text_field.dart';
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final controllerLogin = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPassword2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterScreen'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 100),
            child: Column(
              children: [
                AppTextField(
                  controller: controllerLogin,
                  labelText: 'login',
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextField(
                  controller: controllerEmail,
                  labelText: 'email',
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
                AppTextField(
                  obscureText: true,
                  controller: controllerPassword2,
                  labelText: 'repeat password',
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextButton(
                  backgroundColor: Colors.blueGrey,
                  onPressed: () {
                    if (formKey.currentState?.validate() != true) return;
                    if (controllerPassword2.text != controllerPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password mismatch')));
                    } else {
                      _onTapToSignUp(context.read<AuthCubit>());
                      Navigator.of(context).pop();
                    }
                  },
                  textButton: 'sign up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapToSignUp(AuthCubit authCubit) => authCubit.signUp(
        username: controllerLogin.text,
        password: controllerPassword.text,
        email: controllerEmail.text,
      );
}
