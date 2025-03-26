import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget buildAdaptiveButton(
    BuildContext context, VoidCallback onPressed, String text) {
  final platform = Theme.of(context).platform;

  if (platform == TargetPlatform.iOS || kIsWeb) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Text(text),
    );
  } else {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
