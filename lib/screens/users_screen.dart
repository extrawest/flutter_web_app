import 'package:flutter/material.dart';
import 'package:flutterwebapp/widgets/user_list.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Material(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Flexible(child: UserList(useWideLayout: true)),
                  Expanded(flex: 4, child: SizedBox()),
                ],
              );
            }
            return const UserList(useWideLayout: false);
          },
        ),
      ),
    );
  }
}
