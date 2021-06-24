import 'package:flutter/material.dart';

class MasterDetailTemplate extends StatelessWidget {
  final bool showDetailWidget;
  final Widget master;
  final Widget? details;

  const MasterDetailTemplate({Key? key, required this.showDetailWidget, required this.master, this.details}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(showDetailWidget){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(child: master),
          Expanded(flex: 3, child: details ?? const SizedBox()),
        ],
      );
    }
    return details!;
  }
}
