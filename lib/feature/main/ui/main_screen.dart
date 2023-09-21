import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:client_it/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:client_it/feature/auth/ui/user_screen.dart';
import 'package:client_it/feature/posts/ui/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainScreen'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserScreen(),
                    ),
                  ),
              icon: const Icon(Icons.account_box)),
        ],
      ),
      body: const PostList(),
    );
  }
}
