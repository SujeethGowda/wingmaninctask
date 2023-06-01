import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> showSnackbar([
  String? msg,
  int? time,
  BuildContext? context,
  Color? color,
]) async {
  ScaffoldMessenger.of(context ?? StackedService.navigatorKey!.currentContext!)
      .showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      backgroundColor: color,
      content: Text(
        msg ?? "Something went Wrong",
        style: const TextStyle(color: Colors.white),
      ),
      duration: Duration(milliseconds: time ?? 3000),
    ),
  );
}

Future<void> showSuccessSnackbar(
    [String? msg, BuildContext? context, Duration? duration]) async {
  ScaffoldMessenger.of(context ?? StackedService.navigatorKey!.currentContext!)
      .showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        msg ?? "Something went wrong",
        style: const TextStyle(color: Colors.white),
      ),
      duration: duration ?? const Duration(milliseconds: 2000),
    ),
  );
}
