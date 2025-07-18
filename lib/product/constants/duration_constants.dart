import 'package:flutter/material.dart';

@immutable
class DurationConstants{
  const DurationConstants._();
  static const DurationConstants durationInstance = DurationConstants._();
  Duration get splashDuration => const Duration(milliseconds: 2000);
  Duration get splashIconDelay => const Duration(milliseconds: 1000);

}