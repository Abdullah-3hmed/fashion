import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/core/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:internet_state_manager/internet_state_manager.dart';

class CustomInternetChecker extends StatefulWidget {
  const CustomInternetChecker({
    super.key,
    required this.child,
    required this.onRestoreInternetConnection,
  });

  final Widget child;
  final void Function() onRestoreInternetConnection;

  @override
  State<CustomInternetChecker> createState() => _CustomInternetCheckerState();
}

class _CustomInternetCheckerState extends State<CustomInternetChecker> {
  bool _isFirstCheckDone = false;

  @override
  Widget build(BuildContext context) {
    return InternetStateManager.builder(
      onRestoreInternetConnection: widget.onRestoreInternetConnection,
      builder: (context, state) {
        if (!_isFirstCheckDone) {
          if (state.status.isConnected || state.status.isDisconnected) {
            _isFirstCheckDone = true;
          } else {
            return widget.child;
          }
        }

        if (state.status.isConnected) {
          return widget.child;
        } else {
          return NoInternetWidget(
            onPressed: () {
              showToast(
                message: "No Internet Connection",
                state: ToastStates.error,
              );
            },
          );
        }
      },
    );
  }
}
