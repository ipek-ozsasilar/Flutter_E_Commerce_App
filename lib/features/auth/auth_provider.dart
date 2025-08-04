import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app/product/enums/secure_storage.dart';
import 'package:riverpod/riverpod.dart';

/*
Firebase'in Otomatik Yaptıkları:
- Login Persistence: App açılışında otomatik login
- Token Refresh: Süresi dolan token'ları otomatik yeniler
- Token Cache: Internal cache ile süper hızlı token erişimi (Memory + Disk)
- Firestore/Storage Auth: Otomatik header management
- Security: Secure token storage kendi içinde
- Network Optimization: Batch requests, connection pooling
- Battery Optimization: Background refresh, minimal network calls
 */

final authhProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider();
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(const AuthState(isLoggedIn: false));

  Future<void> checkAuthStatus() async {
    try {
      // Firebase Auth user kontrolü
      final User? user = FirebaseAuth.instance.currentUser;

      //if user is not null update logged in true
      if (user != null) {
        updateLoggedInTrue();
      } else {
        //if user is null update logged in false
        updateLoggedInFalse();
      }
    } catch (e) {
      //if error update logged in false
      updateLoggedInFalse();
    }
  }

  //logout function
  void logout() async {
    await FirebaseAuth.instance.signOut();
    // Token clear
    await SecureStorageKeys.token.writeKeys('');
    state = state.copyWith(isLoggedIn: false);
  }

  //update logged in true
  void updateLoggedInTrue() {
    state = state.copyWith(isLoggedIn: true);
  }

  //update logged in false
  void updateLoggedInFalse() {
    state = state.copyWith(isLoggedIn: false);
  }
}

class AuthState extends Equatable {
  final bool isLoggedIn;

  const AuthState({required this.isLoggedIn});

  @override
  List<Object?> get props => [isLoggedIn];

  AuthState copyWith({bool? isLoggedIn}) {
    return AuthState(isLoggedIn: isLoggedIn ?? this.isLoggedIn);
  }
}
