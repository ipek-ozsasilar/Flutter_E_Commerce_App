import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

final formProvider = StateNotifierProvider<FormNotifier, FormState>((ref) {
  return FormNotifier();
});

class FormNotifier extends StateNotifier<FormState> {
  FormNotifier()
      : super(FormState(
          email: '',
          password: '',
          isObscureText: true,
        ));
 
  void setEmail(String email) => state = state.copyWith(email: email);
  void setPassword(String password) => state = state.copyWith(password: password);
  void toggleObscureText() => state = state.copyWith(isObscureText: !state.isObscureText);


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();
  final TextEditingController forgotPasswordController =TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    forgotPasswordController.dispose();
    super.dispose();
  }

  bool checkEmptyEmailAndPassword() => emailController.text.isEmpty || passwordController.text.isEmpty;

  bool checkPasswordLength() => passwordController.text.length >= 6;

  bool checkConfirmPasswordLength() => confirmPasswordController.text.length >= 6;

  bool checkForgotPasswordEmailEmpty() => forgotPasswordController.text.isEmpty;

  bool checkResetPasswordEmailEmpty() => passwordController.text.isEmpty || confirmPasswordController.text.isEmpty;

  bool passwordsSame() => passwordController.text == confirmPasswordController.text;

  void clearTextEmail() {
    emailController.clear();
  }

  void clearTextPassword() {
    passwordController.clear();
  }

  void clearTextConfirmPassword() {
    confirmPasswordController.clear();
  }

  void clearTextForgotPassword() {
    forgotPasswordController.clear();
  }
}

class FormState extends Equatable {
  final String email;
  final String password;
  final bool isObscureText;

  FormState({
    required this.email,
    required this.password,
    required this.isObscureText,
  });

  FormState copyWith({
    String? email,
    String? password,
    bool? isObscureText,
  }) {
    return FormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isObscureText: isObscureText ?? this.isObscureText,
    );
  }

  @override
  List<Object?> get props => [email, password, isObscureText];
}
