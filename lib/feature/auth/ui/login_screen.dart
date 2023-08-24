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
                TextFormField(
                  validator: emptyValidator,
                  maxLines: 1,
                  controller: controllerLogin,
                  decoration: const InputDecoration(
                    labelText: 'login',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: emptyValidator,
                  maxLines: 1,
                  controller: controllerPassword,
                  decoration: const InputDecoration(
                    labelText: 'password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      print('OK');
                    }
                  },
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                    const Size(double.maxFinite, 40),
                  )),
                  child: const Text('login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value?.isEmpty == true) {
      return 'cannot be empty';
    }
    return null;
  }
}
