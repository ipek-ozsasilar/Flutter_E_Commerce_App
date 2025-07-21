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

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider();  
}); 

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(const AuthState(isLoggedIn: false, hasSeenOnboarding: false));

  Future<void> checkAuthStatus() async {
    log("🔍 Auth status kontrol ediliyor...");
    
    try {
      // Firebase Auth user kontrolü
      final User? user = FirebaseAuth.instance.currentUser;
      
      // ✅ Storage'dan onboarding durumu oku
      final String hasSeenOnboardingValue = await SecureStorageKeys.hasSeenOnboarding.readKeys();
      final bool hasSeenOnboarding = hasSeenOnboardingValue == 'true';
      
      log("👤 User: ${user?.uid ?? 'null'}");
      log("📦 Storage'dan okunan: '$hasSeenOnboardingValue'");
      log("📚 Has seen onboarding: $hasSeenOnboarding");
      
      // ✅ State güncelle
      state = state.copyWith(
        isLoggedIn: user != null,
        hasSeenOnboarding: hasSeenOnboarding,
      );
      
      log("🎯 Final state - isLoggedIn: ${state.isLoggedIn}, hasSeenOnboarding: ${state.hasSeenOnboarding}");
      
    } catch (e) {
      log("💥 Auth kontrol hatası: $e");
      // Hata durumunda güvenli varsayılan değerler
      state = state.copyWith(
        isLoggedIn: false,
        hasSeenOnboarding: false,
      );
    }
  }

  void setOnboardingCompleted() async {
    log("✅ Onboarding tamamlandı");
    await SecureStorageKeys.hasSeenOnboarding.writeKeys('true');
    state = state.copyWith(hasSeenOnboarding: true);
    log("💾 Storage'a yazıldı: 'true'");
  }

  void logout() async {
    log("🚪 Logout işlemi");
    
    // Firebase Auth'dan çıkış yap
    await FirebaseAuth.instance.signOut();
    
    // ✅ HER İKİSİNİ DE temizle
    await SecureStorageKeys.token.writeKeys('');
    await SecureStorageKeys.hasSeenOnboarding.writeKeys('');
    
    state = state.copyWith(
      isLoggedIn: false,
      hasSeenOnboarding: false, // ✅ Bu eksikti!
    );
    
    log("🗑️ Tüm storage temizlendi");
  }
}

class AuthState extends Equatable {
  final bool isLoggedIn;
  final bool hasSeenOnboarding;
  
  const AuthState({
    required this.isLoggedIn,
    required this.hasSeenOnboarding,
  });

  @override
  List<Object?> get props => [isLoggedIn, hasSeenOnboarding];

  AuthState copyWith({
    bool? isLoggedIn,
    bool? hasSeenOnboarding,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }
}