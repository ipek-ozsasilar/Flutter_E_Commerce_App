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
    : super(AuthState(isValidEmail: false, isLoading: false));

  void setEmailVerified(bool emailVerified) =>
      state = state.copyWith(isValidEmail: emailVerified);

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
    _logger.i('Email: ${ref.read(formProvider.notifier).emailController.text}');
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
  }

  Future<User?> createAccountWithEmailAndPassword() async {
    _logger.i('Email: ${ref.read(formProvider.notifier).emailController.text}');
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
    _logger.i('Creating account with Firebase email/password');
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: ref.read(formProvider.notifier).emailController.text,
          password: ref.read(formProvider.notifier).passwordController.text,
        );
    setLoading(false);
    return userCredential.user;
  }

  Future<void> sendPasswordResetEmail() async {
  
      setLoading(true);
      final email = ref
          .read(formProvider.notifier)
          .forgotPasswordController
          .text.trim();


      // Kullanıcı varsa email gönder
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _logger.w("Şifre sıfırlama maili gönderildi.");
      return; // Başarılı durumda return et
    
  }

  Future<void> signOutAuth() async => await FirebaseAuth.instance.signOut();
}

class AuthState extends Equatable {
  final bool isValidEmail;
  final bool isLoading;

  const AuthState({required this.isValidEmail, required this.isLoading});

  AuthState copyWith({bool? isValidEmail, bool? isLoading}) {
    return AuthState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isValidEmail, isLoading];
}
