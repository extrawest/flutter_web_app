import 'package:flutter/material.dart';
import 'package:flutterwebapp/network/exception.dart';

class ApiExceptionWidget extends StatelessWidget {
  final APIException apiException;

  const ApiExceptionWidget({Key? key, required this.apiException}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(apiException.toString()),
    );
  }
}
