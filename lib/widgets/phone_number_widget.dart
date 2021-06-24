import 'package:flutter/material.dart';
import 'package:flutterwebapp/utils/launch_helper.dart';

class PhoneNumberWidget extends StatelessWidget with LaunchHelper {
  final String? phoneNumber;

  const PhoneNumberWidget({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.call), onPressed: _dial),
        const SizedBox(width: 16),
        Expanded(child: Text(phoneNumber!)),
      ],
    );
  }

  void _dial() {
    launchUrl(url: 'tel:$phoneNumber');
  }
}
