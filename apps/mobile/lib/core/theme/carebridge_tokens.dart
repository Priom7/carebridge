import 'package:flutter/material.dart';

abstract final class CareColors {
  static const blue = Color(0xFF075CD6);
  static const blueDark = Color(0xFF0646A6);
  static const blueSoft = Color(0xFFEAF3FF);
  static const teal = Color(0xFF09A9A2);
  static const tealSoft = Color(0xFFE7F8F6);
  static const green = Color(0xFF16A66A);
  static const greenSoft = Color(0xFFE8F8F0);
  static const amber = Color(0xFFF3A51C);
  static const amberSoft = Color(0xFFFFF6DE);
  static const red = Color(0xFFE33B45);
  static const redSoft = Color(0xFFFFECEE);
  static const ink = Color(0xFF10233F);
  static const slate = Color(0xFF53657D);
  static const line = Color(0xFFDDE6F0);
  static const canvas = Color(0xFFF5F9FD);
  static const white = Color(0xFFFFFFFF);
  static const darkCanvas = Color(0xFF091422);
  static const darkSurface = Color(0xFF122238);
}

abstract final class CareSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

abstract final class CareRadius {
  static const sm = 10.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const pill = 999.0;
}

abstract final class CareMotion {
  static const quick = Duration(milliseconds: 160);
  static const standard = Duration(milliseconds: 240);
}
