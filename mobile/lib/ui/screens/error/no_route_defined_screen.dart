import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoRouteDefinedScreen extends StatelessWidget {
  final GoRouterState state;

  const NoRouteDefinedScreen({super.key,
    required this.state
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No route defined for ${state.fullPath}'),
      ),
    );
  }
}