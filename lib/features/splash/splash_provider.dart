import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_e_commerce_app/core/injection_manager.dart';
import 'package:flutter_e_commerce_app/models/version_model.dart';
import 'package:flutter_e_commerce_app/product/enums/firebase_collections.dart';
import 'package:flutter_e_commerce_app/product/enums/platform_enum.dart';
import 'package:flutter_e_commerce_app/product/utility/firebase/version_manager.dart';
import 'package:riverpod/riverpod.dart';


class SplashProvider extends StateNotifier<splashState> {
  SplashProvider(): super(splashState(isLoading: false, isForceUpdate: false, isRedirectStart: false));

  Future<void> checkVersion(String clientVersion) async {
    log("🚀 checkVersion başladı - Client: $clientVersion");
    
    try {
      final versionData = await getFirebaseData();
      log("📦 Firebase data: $versionData");
      
      if(versionData == null){
        log("❌ Version data null - Force update");
        state = state.copyWith(isForceUpdate: true, isLoading: false);
        return;
      }
      
      final databaseVersion = versionData.number;
      log("🔄 Version karsilastirma - Client: $clientVersion, Server: $databaseVersion");
      
      final isNeedUpdate = getIt<VersionManager>().versionProcess(clientVersion, databaseVersion);
      log("⚡ Update gerekli mi: $isNeedUpdate");
      
      if(isNeedUpdate){
        log("🔴 Force update gösterilecek");
        state = state.copyWith(isForceUpdate: true, isLoading: false);
      } else {
        log("🟢 Login'e yönlendirilecek");
        state = state.copyWith(isForceUpdate: false, isRedirectStart: true, isLoading: false);
      }
    } catch (e) {
      log("💥 Hata: $e");
      state = state.copyWith(isForceUpdate: true,);
    }
  }


    Future<VersionModel?> getFirebaseData() async {
        final versionReference = await FirebaseCollections.version.collectionReference;
        final response=await versionReference.withConverter<VersionModel>(
            fromFirestore: (snapshot, _) => VersionModel.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
        ).doc(PlatformEnum.platformName).get();
        return response.data() as VersionModel;
    }
}
  


class splashState extends Equatable {
  final bool isLoading;
  final bool isForceUpdate;
  final bool isRedirectStart;

  splashState({
    required this.isLoading,
    required this.isForceUpdate,
    required this.isRedirectStart,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, isForceUpdate, isRedirectStart ];

  splashState copyWith({
    bool? isLoading,
    bool? isForceUpdate,
    bool? isRedirectStart,
  }) {
    return splashState(
      isLoading: isLoading ?? this.isLoading,
      isForceUpdate: isForceUpdate ?? this.isForceUpdate,
      isRedirectStart: isRedirectStart ?? this.isRedirectStart,
    );
  }


}
