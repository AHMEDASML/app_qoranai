
import 'package:flutter/material.dart';

import '../../resources/text/text16.dart';

class CustomNoInternet extends StatelessWidget {
  const CustomNoInternet({super.key, required this.error, this.onRefresh});
  final void Function()? onRefresh;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text16(text: error),
          IconButton(
              onPressed: onRefresh, icon: const Icon(Icons.replay_outlined))
        ],
      ),
    );
  }
}
