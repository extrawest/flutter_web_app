import 'package:flutter/material.dart';
import 'package:flutterwebapp/routes.dart';
import 'package:flutterwebapp/widgets/user_list.dart';
import 'package:flutterwebapp/widgets/user_profile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            final profileWidget = UserProfileWidget(
              userId: userId,
              onOpenPosts: (userId) => Navigator.of(context).pushNamed(Routes.userPosts(userId)),
              useWideLayout: sizingInformation.isDesktop,
            );
            if (sizingInformation.isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Flexible(child: UserList(useWideLayout: true)),
                  Expanded(flex: 4, child: profileWidget),
                ],
              );
            }
            return profileWidget;
          },
        ));
  }
}
