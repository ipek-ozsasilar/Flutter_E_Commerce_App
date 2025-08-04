import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final connectionProvider = StateNotifierProvider<ConnectionNotifier, ConnectionState>((ref) {
  return ConnectionNotifier();
});

class ConnectionNotifier extends StateNotifier<ConnectionState> {
  final Logger _logger = Logger();

  ConnectionNotifier()
    : super(
        ConnectionState(
          isConnection: true,
        ),
      );

  void setConnection(bool connection) => state = state.copyWith(isConnection: connection);

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
      setConnection(false);
      _logger.w('Ağ var ama internet yok (DNS çözülemedi)');
    } else {
      setConnection(true);
    }

    return hasInternet;
  }
 
}

class ConnectionState extends Equatable {
  final bool isConnection;

  ConnectionState({
    required this.isConnection,
  });

  ConnectionState copyWith({
    bool? isConnection,
  }) {
    return ConnectionState(
      isConnection: isConnection ?? this.isConnection,
    );
  }

  @override
  List<Object?> get props => [
    isConnection,
  ];
}
