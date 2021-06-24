import 'package:flutter/material.dart';

class WrongAddressScreen extends StatelessWidget {
  const WrongAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wrong address')),
      body: const Center(
        child: Text('Error 404.\nPage has not been found', textAlign: TextAlign.center),
      ),
    );
  }
}
