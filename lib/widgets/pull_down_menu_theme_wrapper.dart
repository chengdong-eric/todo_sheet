// Not in use

import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

class PullDownMenuThemeWrapper extends StatelessWidget {
  final Widget child;

  const PullDownMenuThemeWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final parentTheme = Theme.of(context);

    return Theme(
      data: parentTheme.copyWith(
        extensions: <ThemeExtension<dynamic>>[
          PullDownButtonTheme(
            itemTheme: PullDownMenuItemTheme(
              textStyle: TextStyle(
                fontFamily: parentTheme.textTheme.titleMedium?.fontFamily,
              ),
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}
