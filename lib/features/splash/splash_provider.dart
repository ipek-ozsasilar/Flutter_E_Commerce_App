import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/models/version_model.dart';
import 'package:flutter_e_commerce_app/product/enums/firebase_collections.dart';
import 'package:flutter_e_commerce_app/product/enums/platform_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/firebase/version_manager.dart';
import 'package:riverpod/riverpod.dart';


class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider()
      : super(
          const SplashState(
            isForceUpdate: false,
            isRedirectStart: false,
          ),
        );

  Future<void> checkVersion(String clientVersion) async {
    log("🚀 checkVersion başladı - Client: $clientVersion");

    try {
      final versionData = await getFirebaseData();
      log("📦 Firebase data: $versionData");

      if (versionData == null) {
        log("❌ Version data null - Force update");
        state = state.copyWith(isForceUpdate: true);
        return;
      }

      final databaseVersion = versionData.number;
      log(
        "🔄 Version karşılaştırma - Client: $clientVersion, Server: $databaseVersion",
      );

      final isNeedUpdate = getIt<VersionManager>().versionProcess(
        clientVersion,
        databaseVersion,
      );
      log("⚡ Update gerekli mi: $isNeedUpdate");

      if (isNeedUpdate) {
        log("🔴 Force update gösterilecek");
        state = state.copyWith(isForceUpdate: true);
      } else {
        log("✅ Version check başarılı");
        state = state.copyWith(isForceUpdate: false,isRedirectStart: true);
      }
    } catch (e) {
      log("💥 Version check hatası: $e");
      state = state.copyWith(isForceUpdate: true);
    }
  }

  Future<VersionModel?> getFirebaseData() async {
    final versionReference =
        await FirebaseCollections.version.collectionReference;
    final response = await versionReference
        .withConverter<VersionModel>(
          fromFirestore: (snapshot, _) =>
              VersionModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .doc(PlatformEnum.platformName)
        .get();
    return response.data() as VersionModel;
  }
}

class SplashState extends Equatable {
  final bool isForceUpdate;
  final bool isRedirectStart;

  const SplashState({
    required this.isForceUpdate,
    required this.isRedirectStart,
  });

  @override
  List<Object?> get props => [isForceUpdate, isRedirectStart];

  SplashState copyWith({
    bool? isForceUpdate,
    bool? isRedirectStart,
  }) {
    return SplashState(
      isForceUpdate: isForceUpdate ?? this.isForceUpdate,
      isRedirectStart: isRedirectStart ?? this.isRedirectStart,
    );
  }
}

// Global provider
final splashProvider = StateNotifierProvider<SplashProvider, SplashState>(
  (ref) => SplashProvider(),
);