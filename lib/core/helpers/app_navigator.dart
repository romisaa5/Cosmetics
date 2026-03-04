import 'package:flutter/material.dart';

class AppNavigator {
  /// Push
  static Future<T?> push<T>(BuildContext context, Widget page) {
    return Navigator.push<T>(context, MaterialPageRoute(builder: (_) => page));
  }

  /// Push Replacement
  static Future<T?> pushReplacement<T, TO>(BuildContext context, Widget page) {
    return Navigator.pushReplacement<T, TO>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Push And Remove Until
  static Future<T?> pushAndRemoveUntil<T>(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  /// Pop
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  /// Pop Until
  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  /// Maybe Pop
  static Future<bool> maybePop(BuildContext context) {
    return Navigator.maybePop(context);
  }
}
