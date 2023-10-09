import 'package:client_it/app/ui/app_loader.dart';
import 'package:client_it/feature/posts/domain/state/cubit/post_cubit.dart';
import 'package:client_it/feature/posts/ui/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template post_list}
/// PostList widget.
/// {@endtemplate}
class PostList extends StatelessWidget {
  /// {@macro post_list}
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.postList.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.postList.length,
            itemBuilder: (context, index) {
              return PostItem(postEntity: state.postList[index]);
            },
          );
        }
        if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
