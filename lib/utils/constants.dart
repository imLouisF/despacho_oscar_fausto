import 'package:flutter/material.dart';

/// Application-wide constants for design consistency
/// 
/// Usage:
/// ```dart
/// import 'package:despacho_oscar_fausto/utils/constants.dart';
/// 
/// Container(
///   color: kPrimaryColor,
///   padding: EdgeInsets.all(kPadding),
///   child: Text(appName, style: kTitleStyle),
/// )
/// ```

// ==================== Color Palette ====================

/// Primary brand color - Deep purple
const Color kPrimaryColor = Color(0xFF673AB7);

/// Accent color - Lighter purple shade
const Color kAccentColor = Color(0xFF9575CD);

/// Background color - Light grey
const Color kBackgroundColor = Color(0xFFF5F5F5);

/// Primary text color - Dark grey
const Color kTextColor = Color(0xFF212121);

/// Subtitle and secondary text color - Medium grey
const Color kSubtitleColor = Color(0xFF757575);

/// Card background color - White
const Color kCardColor = Colors.white;

// ==================== Spacing Constants ====================

/// Standard padding value
const double kPadding = 16.0;

/// Standard margin value
const double kMargin = 16.0;

/// Standard border radius
const double kRadius = 12.0;

/// Standard elevation for cards and buttons
const double kElevation = 2.0;

// ==================== Text Styles ====================

/// Title text style - Bold, large
const TextStyle kTitleStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: kTextColor,
);

/// Subtitle text style - Medium size, secondary color
const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 16,
  color: kSubtitleColor,
);

/// Button text style - Semi-bold, white color
const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

/// Small text style - For captions and labels
const TextStyle kSmallTextStyle = TextStyle(
  fontSize: 14,
  color: kSubtitleColor,
);

// ==================== String Constants ====================

/// Application name
const String appName = 'Despacho Oscar & Fausto';

/// Home screen title
const String homeTitle = 'Inicio';

/// Agenda screen title
const String agendaTitle = 'Agenda';

/// Casos (Cases) screen title
const String casosTitle = 'Casos';

/// Comunicación (Communication) screen title
const String comunicacionTitle = 'Comunicación';

/// Formularios (Forms) screen title
const String formulariosTitle = 'Formularios';

/// Firma (Signature) screen title
const String firmaTitle = 'Firma';