import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasha_insurance/utils/helpers/app_loger.dart';

extension GoRouterExtension on GoRouter { //?
  void removeUntil(BuildContext context, {required String removeUntil}) {
    final GoRouter router = GoRouter.of(context);
    
    while (router.routerDelegate.currentConfiguration.fullPath != removeUntil) {
      logger.d("popping -> ${router.routerDelegate.currentConfiguration.fullPath}");

      if (!router.canPop()) {
        logger.d("can't pop");
        return;
      }

      router.pop();
    }
  }
}