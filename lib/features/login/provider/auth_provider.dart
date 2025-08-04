import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Logger _logger = Logger();
  final Ref ref;

  AuthNotifier(this.ref)
    : super(
        AuthState(isValidEmail: false, isConnection: false, isLoading: false),
      );

  void setEmailVerified(bool emailVerified) => state = state.copyWith(isValidEmail: emailVerified);

  void setLoading(bool value) => state = state.copyWith(isLoading: value);

  Future<bool> isEmailVerified() async {
    final User? user = FirebaseAuth.instance.currentUser;
    bool isEmailVerifiedResult = false;
    user?.reload();
    if (user != null) {
      isEmailVerifiedResult = user.emailVerified;
      setEmailVerified(isEmailVerifiedResult);
      return isEmailVerifiedResult;
    }
    return isEmailVerifiedResult;
  }

  Future<User?> signInWithEmailAndPassword() async {
    try {
      _logger.i(
        'Email: ${ref.read(formProvider.notifier).emailController.text}',
      );
      ref
          .read(formProvider.notifier)
          .setEmail(ref.read(formProvider.notifier).emailController.text);
      _logger.i(
        'Password: ${ref.read(formProvider.notifier).passwordController.text}',
      );
      ref
          .read(formProvider.notifier)
          .setPassword(ref.read(formProvider.notifier).passwordController.text);

      setLoading(true);
      _logger.i('Signing in with Firebase email/password');
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: ref.read(formProvider.notifier).emailController.text,
            password: ref.read(formProvider.notifier).passwordController.text,
          );
      setLoading(false);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _logger.e('Sign in error: $e');
      setLoading(false);
      return null;
    }
  }


  Future<void> signOutAuth() async => await FirebaseAuth.instance.signOut();
}

class AuthState extends Equatable {
  final bool isValidEmail;
  final bool isConnection;
  final bool isLoading;

  const AuthState({
    required this.isValidEmail,
    required this.isConnection,
    required this.isLoading,
  });

  AuthState copyWith({
    bool? isValidEmail,
    bool? isConnection,
    bool? isLoading,
  }) {
    return AuthState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isConnection: isConnection ?? this.isConnection,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isValidEmail, isConnection, isLoading];
}
