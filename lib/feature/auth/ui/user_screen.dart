import 'package:client_it/app/domain/error_entity/error_entity.dart';
import 'package:client_it/app/ui/app_loader.dart';
import 'package:client_it/app/ui/components/app_dialog.dart';
import 'package:client_it/app/ui/components/app_snack_bar.dart';
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
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
                // context.read<PostCubit>().logOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authorized: (userEntity) {
              if (userEntity.userState?.hasData == true) {
                AppSnackBar.showSnackBarWithMessage(
                    context, userEntity.userState?.data);
              }
              if (userEntity.userState?.hasError == true) {
                AppSnackBar.showSnackBarWithError(context,
                    ErrorEntity.fromException(userEntity.userState?.error));
              }
            },
          );
        },
        builder: (context, state) {
          final userEntity =
              state.whenOrNull(authorized: (userEntity) => userEntity);
          if (userEntity?.userState?.connectionState ==
              ConnectionState.waiting) {
            return const AppLoader();
          }
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              // const _UserUpdatePasswordDialog(),
                              AppDialog(
                            val1: 'old',
                            val2: 'new',
                            onPressed: ((v1, v2) {
                              context.read<AuthCubit>().passwordUpdate(
                                    newPassword: v1,
                                    oldPassword: v2,
                                  );
                            }),
                          ),
                        );
                      },
                      child: const Text('Обновить пароль'),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AppDialog(
                            val1: 'username',
                            val2: 'email',
                            onPressed: ((v1, v2) {
                              context
                                  .read<AuthCubit>()
                                  .userUpdate(email: v2, username: v1);
                            }),
                          ),
                        );
                      },
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

// class _UserUpdateDialog extends StatefulWidget {
//   const _UserUpdateDialog({super.key});

//   @override
//   State<_UserUpdateDialog> createState() => __UserUpdateDialogState();
// }

// class __UserUpdateDialogState extends State<_UserUpdateDialog> {
//   final emailController = TextEditingController();
//   final userController = TextEditingController();

//   @override
//   void dispose() {
//     emailController.dispose();
//     userController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SimpleDialog(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               AppTextField(controller: userController, labelText: 'username'),
//               const SizedBox(height: 16),
//               AppTextField(controller: emailController, labelText: 'email'),
//               const SizedBox(height: 16),
//               AppTextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     context.read<AuthCubit>().userUpdate(
//                           username: userController.text,
//                           email: emailController.text,
//                         );
//                   },
//                   textButton: 'Применить'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _UserUpdatePasswordDialog extends StatefulWidget {
//   const _UserUpdatePasswordDialog({super.key});

//   @override
//   State<_UserUpdatePasswordDialog> createState() =>
//       __UserUpdatePasswordDialogState();
// }

// class __UserUpdatePasswordDialogState extends State<_UserUpdatePasswordDialog> {
//   final newController = TextEditingController();
//   final oldController = TextEditingController();

//   @override
//   void dispose() {
//     newController.dispose();
//     oldController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SimpleDialog(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               AppTextField(
//                   controller: oldController, labelText: 'old password'),
//               const SizedBox(height: 16),
//               AppTextField(
//                   controller: newController, labelText: 'new passowrd'),
//               const SizedBox(height: 16),
//               AppTextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     context.read<AuthCubit>().passwordUpdate(
//                           newPassword: newController.text,
//                           oldPassword: oldController.text,
//                         );
//                   },
//                   textButton: 'Применить'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
