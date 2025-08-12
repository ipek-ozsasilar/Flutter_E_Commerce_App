import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

class ThemeProvider extends StateNotifier<ThemeState> {

  ThemeProvider() : super(ThemeState(themeMode: ThemeMode.light));


  void toggleTheme() {
    state = state.copyWith(themeMode: state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}

class ThemeState extends Equatable {
  ThemeMode themeMode;

  ThemeState({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }
} 

final themeStateProvider = StateNotifierProvider<ThemeProvider, ThemeState>((ref) {
  return ThemeProvider();
});