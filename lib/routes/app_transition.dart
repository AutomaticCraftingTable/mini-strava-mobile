import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTransition {
  const AppTransition._();

  static CustomTransitionPage<T> fade<T>(
      GoRouterState state,
      Widget child, {
        Duration duration = const Duration(milliseconds: 300),
        Curve curve = Curves.easeInOutCirc,
      }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration:const Duration(seconds: 1),
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondary, child) {
        final curved = animation.drive(CurveTween(curve: curve));
        return FadeTransition(opacity: curved, child: child);
      },
    );
  }
}
