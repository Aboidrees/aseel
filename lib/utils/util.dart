import 'package:aseel/utils/enums.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showMessage(
    BuildContext context,
    String title,
    String message, {
    bool isConfirmationDialog = false,
    String okText = "حسناً",
    String cancelText = "إلغاء",
    VoidCallback? onCancel,
    VoidCallback? onOk,
    TextStyle? cancelTextStyle,
    TextStyle? okTextStyle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            MaterialButton(
              onPressed: onCancel ?? () {},
              child: Text(cancelText, style: cancelTextStyle),
            ),
            Visibility(
              visible: onOk != null,
              child: MaterialButton(
                onPressed: onOk,
                child: Text(okText, style: okTextStyle),
              ),
            ),
          ],
        );
      },
    );
  }

  static bool isInitial(LoadingStatus loadingStatus) => loadingStatus == LoadingStatus.initial;

  static bool isLoading(LoadingStatus loadingStatus) => loadingStatus == LoadingStatus.loading;

  static bool isStable(LoadingStatus loadingStatus) => loadingStatus == LoadingStatus.stable;
}
