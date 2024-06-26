import 'package:flutter/material.dart';

class HideKeyboardWrapper extends StatelessWidget {
  final Widget? child;

  const HideKeyboardWrapper({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          if (FocusManager.instance.primaryFocus != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        }
      },
    );
  }
}
