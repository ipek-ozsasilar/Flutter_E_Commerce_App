import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginWelcomeBack extends ConsumerStatefulWidget {
  const LoginWelcomeBack({super.key});

  @override
  ConsumerState<LoginWelcomeBack> createState() => _LoginWelcomeBackState();
}

class _LoginWelcomeBackState extends ConsumerState<LoginWelcomeBack> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Login'),
    );
  }
}