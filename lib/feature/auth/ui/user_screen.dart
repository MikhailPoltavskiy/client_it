import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:client_it/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Личный кабинет'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<AuthCubit>().logOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final userEntity =
              state.whenOrNull(authorized: (userEntity) => userEntity);
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Text(userEntity?.username.split('').first ??
                          'Отсутствует'),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      children: [
                        Text(userEntity?.username ?? ''),
                        Text(userEntity?.email ?? ''),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Обновить пароль'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Обновить данные'),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
