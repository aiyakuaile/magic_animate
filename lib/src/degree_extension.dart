import 'dart:math';

extension DegreeToRadian on double {
  double toRadians() => this * pi / 180;
}
