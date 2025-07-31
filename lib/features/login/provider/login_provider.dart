import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/home_view.dart';
import 'package:flutter_e_commerce_app/product/utility/navigator/navigator.dart';
import 'package:kartal/kartal.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<LoginState> {
  final Logger _logger = Logger();

  LoginNotifier()
    : super(
        LoginState(
          email: '',
          password: '',
          isObscureText: true,
          isLoading: true,
          isValidEmail: false,
        ),
      );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController forgotPasswordController =
      TextEditingController();

  bool get isObscureText => state.isObscureText;

  void changeObscureText() {
    state = state.copyWith(isObscureText: !state.isObscureText);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setIsLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }

  void setEmailVerified(bool emailVerified) {
    state = state.copyWith(isValidEmail: emailVerified);
  }

  Future<bool> checkInternetConnection() async {
    final Connectivity _connectivity = Connectivity();
    final connectivityResult = await _connectivity.checkConnectivity();

    // Ağ bağlı mı kontrolü
    if (connectivityResult == ConnectivityResult.none) {
      _logger.w('Cihazda aktif ağ bağlantısı yok.');
      return false;
    }

    // Gerçekten internete çıkış var mı (DNS testi)
    final hasInternet = await InternetAddress.lookup('google.com')
        .then((value) => value.isNotEmpty && value[0].rawAddress.isNotEmpty)
        .catchError((_) => false);

    _logger.i('connectivityResult: $connectivityResult');
    _logger.i('hasInternetAccess: $hasInternet');

    if (!hasInternet) {
      _logger.w('Ağ var ama internet yok (DNS çözülemedi)');
    }

    return hasInternet;
  }

  Future<User?> signInWithEmailAndPassword() async {
    try {
      _logger.i('Email: ${emailController.text}');
      setEmail(emailController.text ?? '');
      _logger.i('Password: ${passwordController.text}');
      setPassword(passwordController.text ?? '');
      _logger.d('Loading state: ${state.isLoading}');
      setIsLoading();
      _logger.i('Signing in with Firebase email/password');
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      setIsLoading();
      _logger.d('Loading state after sign in: ${state.isLoading}');
      return userCredential.user;
    } catch (e) {
      _logger.e('Sign in error: $e');
      setIsLoading();
      return null;
    }
  }
}

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isObscureText;
  final bool isLoading;
  final bool isValidEmail;
  final Widget? page;

  LoginState({
    required this.email,
    required this.password,
    required this.isObscureText,
    required this.isLoading,
    required this.isValidEmail,
    this.page,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isObscureText,
    bool? isLoading,
    bool? isValidEmail,
    Widget? page,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isObscureText: isObscureText ?? this.isObscureText,
      isLoading: isLoading ?? this.isLoading,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isObscureText,
    isLoading,
    isValidEmail,
    page,
  ];
}
