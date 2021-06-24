import 'package:flutter/material.dart';
import 'package:flutterwebapp/utils/launch_helper.dart';

class UserEmailWidget extends StatelessWidget with LaunchHelper {
  final String? email;

  const UserEmailWidget({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.email), onPressed: _email),
        const SizedBox(width: 16),
        Expanded(child: Text(email!)),
      ],
    );
  }

  void _email() {
    launchUrl(url: 'mailto:$email');
  }
}
