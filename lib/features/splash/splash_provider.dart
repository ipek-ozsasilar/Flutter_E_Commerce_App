import 'package:equatable/equatable.dart';
import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/models/version_model.dart';
import 'package:flutter_e_commerce_app/product/enums/firebase_collections.dart';
import 'package:flutter_e_commerce_app/product/enums/platform_enum.dart';
import 'package:flutter_e_commerce_app/product/enums/secure_storage.dart';
import 'package:flutter_e_commerce_app/product/utility/firebase/version_manager.dart';
import 'package:riverpod/riverpod.dart';

// Global provider
final splashProvider = StateNotifierProvider<SplashProvider, SplashState>(
  (ref) => SplashProvider(),
);

class SplashState extends Equatable {
  final bool isForceUpdate;
  final bool isRedirectStart;
  final bool hasSeenOnboarding;

  const SplashState({
    required this.isForceUpdate,
    required this.isRedirectStart,
    required this.hasSeenOnboarding,
  });

  @override
  List<Object?> get props => [
    isForceUpdate,
    isRedirectStart,
    hasSeenOnboarding,
  ];

  SplashState copyWith({
    bool? isForceUpdate,
    bool? isRedirectStart,
    bool? hasSeenOnboarding,
  }) {
    return SplashState(
      isForceUpdate: isForceUpdate ?? this.isForceUpdate,
      isRedirectStart: isRedirectStart ?? this.isRedirectStart,
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }
}

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider()
    : super(
        const SplashState(
          isForceUpdate: false,
          isRedirectStart: false,
          hasSeenOnboarding: false,
        ),
      );

  Future<void> checkVersion(String clientVersion) async {
    try {
      //get version data from firebase
      final versionData = await getFirebaseData();

      //if version data is null set force update true and return
      if (versionData == null) {
        setForceUpdateTrue();
        return;
      }

      //get version number from version data
      final databaseVersion = versionData.number;

      //compare client version and database version
      final isNeedUpdate = getItInstance<VersionManager>().versionProcess(
        clientVersion,
        databaseVersion,
      );

      //if isNeedUpdate is true set force update true
      if (isNeedUpdate) {
        setForceUpdateTrue();
      } else {
        //if isNeedUpdate is false set redirect start true so navigate to onboarding page
        setRedirectStartTrue();
      }
    } catch (e) {
      setForceUpdateTrue();
    }
  }

  Future<void> checkOnboardingHasSeen() async {
    try {
      setOnboardingReadHasSeenOnboarding();
    } catch (e) {
      setOnboardingFalseHasSeenOnboarding();
    }
  }

  void setRedirectStartTrue() =>
      state = state.copyWith(isForceUpdate: false, isRedirectStart: true);

  void setRedirectStartFalse() =>
      state = state.copyWith(isRedirectStart: false);

  void setForceUpdateTrue() => state = state.copyWith(isForceUpdate: true);

  void setForceUpdateFalse() => state = state.copyWith(isForceUpdate: false);

  void setOnboardingFalseHasSeenOnboarding() =>
      state = state.copyWith(hasSeenOnboarding: false);

  void setOnboardingWriteHasSeenOnboarding() async {
    await SecureStorageKeys.hasSeenOnboarding.writeKeys('true');
    state = state.copyWith(hasSeenOnboarding: true);
  }

  void setOnboardingReadHasSeenOnboarding() async {
    final String hasSeenOnboardingValue = await SecureStorageKeys
        .hasSeenOnboarding
        .readKeys();
    state = state.copyWith(hasSeenOnboarding: hasSeenOnboardingValue == 'true');
  }

  void clearOnboardingStatus() async {
    await SecureStorageKeys.hasSeenOnboarding.writeKeys('');
    state = state.copyWith(hasSeenOnboarding: false);
  }

  //fetch version data from firebase firestore
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
