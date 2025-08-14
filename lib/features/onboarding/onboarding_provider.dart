import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingProvider = StateNotifierProvider<OnboardingProvider, OnboardingState>(
  (ref) => OnboardingProvider(),
);

// State
class OnboardingState extends Equatable {
  final int currentPage;
  final int totalPages;

  const OnboardingState({
    required this.currentPage,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [currentPage, totalPages];

  OnboardingState copyWith({
    int? currentPage,
    int? totalPages,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }


  String get pageIndicator => '${currentPage}/$totalPages';
  bool get isLastPage => currentPage == totalPages - 1;
}


class OnboardingProvider extends StateNotifier<OnboardingState> {
  OnboardingProvider() : super(const OnboardingState(currentPage: 0, totalPages: 3));

  void setPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  void nextPage() {
    if (!state.isLastPage) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      state = state.copyWith(currentPage: state.currentPage - 1);
    }
  }
} 
