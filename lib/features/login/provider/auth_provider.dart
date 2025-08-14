import 'package:equatable/equatable.dart';
import 'package:flutter_e_commerce_app/features/login/provider/form_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_e_commerce_app/product/enums/secure_storage.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Logger _logger = Logger();
  final Ref ref;

  AuthNotifier(this.ref)
    : super(
        const AuthState(
          isLoggedIn: false,
          isValidEmail: false,
          isLoadingEmail: false,
          isLoadingFacebook: false,
          isLoadingGoogle: false,
        ),
      );

  void setEmailVerified(bool emailVerified) =>
      state = state.copyWith(isValidEmail: emailVerified);

  void setLoadingEmail(bool value) =>
      state = state.copyWith(isLoadingEmail: value);
  void setLoadingFacebook(bool value) =>
      state = state.copyWith(isLoadingFacebook: value);
  void setLoadingGoogle(bool value) =>
      state = state.copyWith(isLoadingGoogle: value);

  Future<void> clearFacebookAuthCache() async {
    await FacebookAuth.instance.logOut();
  }

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

  Future<User?> signInWithFacebook() async {
    setFacebookLoading(true);
    //Facebook oturum açma işlemini başlatır. LoginResult sınıfı, Facebook oturum açma işleminin sonucunu içerir.
    //status ( success: Giriş başarılı, cancelled: Kullanıcı giriş işlemini iptal etti, failed: Giriş başarısız oldu).
    //accessToken ( Giriş başarılıysa, kullanıcının Facebook erişim token'ı burada bulunur, Bu token Firebase Authentication
    //gibi servislerde kimlik doğrulama için kullanılır. Başarısız veya iptal durumunda null olur).
    //message( Giriş sırasında oluşan hata mesajı veya bilgi mesajı).

    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      _logger.i('Facebook login successful');
      //Facebook tarafından verilen erişim token'ını (access token) alıyorsun.
      //Bu token, Facebook'un sana verdiği kullanıcı kimlik doğrulama yetkisinin kanıtıdır.
      final OAuthCredential credential = FacebookAuthProvider.credential(
        result.accessToken!.token,
      );
      //tokenı giriş için buraya veriyoruz. Firebase Authentication üzerinden kullanıcı giriş yapar.
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final user = userCredential.user;
      await _persistIdToken(user);
      updateLoggedInTrue();
      return user;
    } else if (result.status == LoginStatus.cancelled) {
      _logger.w('Facebook login cancelled');
      return null;
    } else {
      _logger.w('Facebook login failed: ${result.status}');
      return null;
    }
  }

  void setGoogleLoading(bool value) {
    state = state.copyWith(isLoadingGoogle: value);
  }

  Future<UserCredential> signInWithGoogle() async {
    setGoogleLoading(true);
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw Exception("Google Sign-In cancelled");
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    await _persistIdToken(userCredential.user);
    updateLoggedInTrue();
    return userCredential;
  }

  void setFacebookLoading(bool value) {
    // State içinde isFacebookLoading tut ve güncelle
    // Örneğin copyWith ile
    state = state.copyWith(isLoadingFacebook: value);
  }

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
    setLoadingEmail(true);
    _logger.i('Signing in with Firebase email/password');
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: ref.read(formProvider.notifier).emailController.text,
          password: ref.read(formProvider.notifier).passwordController.text,
        );
    setLoadingEmail(false);
    final user = userCredential.user;
    await _persistIdToken(user);
    updateLoggedInTrue();
    return user;
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

    setLoadingEmail(true);
    _logger.i('Creating account with Firebase email/password');
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: ref.read(formProvider.notifier).emailController.text,
          password: ref.read(formProvider.notifier).passwordController.text,
        );
    setLoadingEmail(false);
    final user = userCredential.user;
    await _persistIdToken(user);
    updateLoggedInTrue();
    return user;
  }

  Future<void> sendPasswordResetEmail() async {
    setLoadingEmail(true);
    final email = ref
        .read(formProvider.notifier)
        .forgotPasswordController
        .text
        .trim();

    // Kullanıcı varsa email gönder
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    _logger.w("Şifre sıfırlama maili gönderildi.");
    return; // Başarılı durumda return et
  }

  Future<void> signOutAuth() async => await FirebaseAuth.instance.signOut();

  // Persist Firebase ID token securely
  Future<void> _persistIdToken(User? user) async {
    try {
      final String? idToken = await user?.getIdToken();
      if (idToken != null && idToken.isNotEmpty) {
        await SecureStorageKeys.token.writeKeys(idToken);
      }
    } catch (e) {
      _logger.w('Failed to persist ID token: $e');
    }
  }
}

class AuthState extends Equatable {
  final bool isLoggedIn;
  final bool isValidEmail;
  final bool isLoadingEmail;
  final bool isLoadingFacebook;
  final bool isLoadingGoogle;

  const AuthState({
    required this.isLoggedIn,
    required this.isValidEmail,
    required this.isLoadingEmail,
    required this.isLoadingFacebook,
    required this.isLoadingGoogle,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isValidEmail,
    bool? isLoadingEmail,
    bool? isLoadingFacebook,
    bool? isLoadingGoogle,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isLoadingEmail: isLoadingEmail ?? this.isLoadingEmail,
      isLoadingFacebook: isLoadingFacebook ?? this.isLoadingFacebook,
      isLoadingGoogle: isLoadingGoogle ?? this.isLoadingGoogle,
    );
  }

  @override
  List<Object?> get props => [
    isLoggedIn,
    isValidEmail,
    isLoadingEmail,
    isLoadingFacebook,
    isLoadingGoogle,
  ];
}
