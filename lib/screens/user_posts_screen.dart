import 'package:flutter/material.dart';
import 'package:flutterwebapp/widgets/user_list.dart';
import 'package:flutterwebapp/widgets/user_posts.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserPostsScreen extends StatelessWidget {
  final String userId;

  const UserPostsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          final userPosts = UserPostsWidget(userId: userId, useWideLayout: sizingInformation.isDesktop);
          if (sizingInformation.isDesktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Flexible(child: UserList(useWideLayout: true)),
                Expanded(flex: 4, child: userPosts),
              ],
            );
          }
          return userPosts;
        },
      ),
    );
  }
}
