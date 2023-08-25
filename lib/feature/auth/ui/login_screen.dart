import 'package:client_it/app/ui/components/app_text_button.dart';
import 'package:client_it/app/ui/components/app_text_field.dart';
import 'package:flutter/material.dart';

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
                      print('OK');
                    }
                  },
                  textButton: 'sign in',
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextButton(
                  backgroundColor: Colors.blueGrey,
                  onPressed: () {},
                  textButton: 'sign up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
