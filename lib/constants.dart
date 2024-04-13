import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String API_URL = 'http://10.0.2.2:8000/';
const String ENDPONT = 'api/';

final Dio client = Dio();
final Options options = Options(
  headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  },
);

const Map<int, Color> slate = {
  50: Color(0xFFf8fafc),
  100: Color(0xFFf1f5f9),
  200: Color(0xFFe2e8f0),
  300: Color(0xFFcbd5e1),
  400: Color(0xFF94a3b8),
  500: Color(0xFF64748b),
  600: Color(0xFF475569),
  700: Color(0xFF334155),
  800: Color(0xFF1e293b),
  900: Color(0xFF0f172a),
  950: Color(0xFF020617),
};

const Map<int, Color> blue = {
  50: Color(0xFFeff6ff),
  100: Color(0xFFdbeafe),
  200: Color(0xFFbfdbfe),
  300: Color(0xFF93c5fd),
  400: Color(0xFF60a5fa),
  500: Color(0xFF3b82f6),
  600: Color(0xFF2563eb),
  700: Color(0xFF1d4ed8),
  800: Color(0xFF1e40af),
  900: Color(0xFF1e3a8a),
  950: Color(0xFF172554),
};

const Map<int, Color> indigo = {
  50: Color(0xFFeef2ff),
  100: Color(0xFFe0e7ff),
  200: Color(0xFFc7d2fe),
  300: Color(0xFFa5b4fc),
  400: Color(0xFF818cf8),
  500: Color(0xFF6366f1),
  600: Color(0xFF4f46e5),
  700: Color(0xFF4338ca),
  800: Color(0xFF3730a3),
  900: Color(0xFF312e81),
  950: Color(0xFF1e1b4b),
};

const Map<int, Color> red = {
  50: Color(0xFFFEF2F2),
  100: Color(0xFFFEE2E2),
  200: Color(0xFFFECACA),
  300: Color(0xFFFCA5A5),
  400: Color(0xFFF87171),
  500: Color(0xFFEF4444),
  600: Color(0xFFDC2626),
  700: Color(0xFFB91C1C),
  800: Color(0xFF991B1B),
  900: Color(0xFF7F1D1D),
  950: Color(0xFF450A0A),
};

const Map<int, Color> green = {
  50: Color(0xFFf0fdf4),
  100: Color(0xFFdcfce7),
  200: Color(0xFFbbf7d0),
  300: Color(0xFF86efac),
  400: Color(0xFF4ade80),
  500: Color(0xFF22c55e),
  600: Color(0xFF16a34a),
  700: Color(0xFF15803d),
  800: Color(0xFF166534),
  900: Color(0xFF14532d),
  950: Color(0xFF052e16),
};

void setPreference(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
  log("Success set $key:$value");
}

Future<String?> loadPreference(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final String? value = prefs.get(key) as String?;
  log("Success load $key:$value");
  return value;
}
