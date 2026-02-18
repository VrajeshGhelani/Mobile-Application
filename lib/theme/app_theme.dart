import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primary = Color(0xFF6366F1);
  static const Color secondary = Color(0xFFEC4899);

  // Light Mode Colors
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightOutline = Color(0xFFE2E8F0);

  // Dark Mode Colors
  static const Color darkSurface = Color(0xFF0F172A);
  static const Color darkBackground = Color(0xFF020617);
  static const Color darkOutline = Color(0xFF1E293B);

  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.white,
      surface: isDark ? darkSurface : lightSurface,
      onSurface: isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A),
      background: isDark ? darkBackground : lightBackground,
      onBackground: isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A),
      outline: isDark ? darkOutline.withValues(alpha: 0.5) : lightOutline,
      outlineVariant: isDark ? darkOutline : lightOutline,
      surfaceVariant: isDark
          ? const Color(0xFF1E293B)
          : const Color(0xFFF1F5F9),
      onSurfaceVariant: isDark
          ? const Color(0xFF94A3B8)
          : const Color(0xFF475569),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,

      // Typography
      textTheme:
          GoogleFonts.outfitTextTheme(
            isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
          ).copyWith(
            displayLarge: GoogleFonts.outfit(
              fontWeight: FontWeight.w900,
              color: colorScheme.onSurface,
            ),
            displayMedium: GoogleFonts.outfit(
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface,
            ),
            displaySmall: GoogleFonts.outfit(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
            headlineLarge: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            headlineMedium: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            titleLarge: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: colorScheme.onSurface,
            ),
            titleMedium: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
            bodyLarge: GoogleFonts.outfit(color: colorScheme.onSurface),
            bodyMedium: GoogleFonts.outfit(
              color: colorScheme.onSurface.withValues(alpha: 0.8),
            ),
            labelLarge: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: colorScheme.onSurface,
            ),
          ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.outfit(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),

      // Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: primary.withValues(alpha: 0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final color = states.contains(WidgetState.selected)
              ? primary
              : colorScheme.onSurface.withValues(alpha: 0.6);
          return GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.bold
                : FontWeight.normal,
            color: color,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final color = states.contains(WidgetState.selected)
              ? primary
              : colorScheme.onSurface.withValues(alpha: 0.6);
          return IconThemeData(color: color, size: 24);
        }),
      ),

      // Bottom Navigation Bar (for legacy components)
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: primary,
        unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? colorScheme.surface : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        hintStyle: GoogleFonts.outfit(
          color: colorScheme.onSurface.withValues(alpha: 0.4),
        ),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: const BorderSide(color: primary, width: 2),
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surface,
        selectedColor: primary.withValues(alpha: 0.1),
        side: BorderSide(color: colorScheme.outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        labelStyle: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
