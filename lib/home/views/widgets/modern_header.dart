import 'package:flutter/material.dart';

/// A modern, animated header component for the Brain Tumor AI application.
///
/// Features:
/// - Scale and fade-in entrance animation
/// - Glassmorphism design with gradient background
/// - Prominent brand icon with shadow effects
/// - Professional medical AI messaging
/// - Responsive typography hierarchy
/// - Clean card layout with proper spacing
class ModernHeader extends StatelessWidget {
  const ModernHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Scale and fade entrance animation for engaging first impression
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800), // Slower for prominence
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value), // Scale from 80% to 100%
          child: Opacity(
            opacity: value, // Fade-in effect
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                // Glassmorphism gradient effect
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(
                      alpha: 0.9,
                    ), // Strong opacity at top
                    Colors.white.withValues(alpha: 0.1), // Faded at bottom
                  ],
                ),
                // Subtle border for depth
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
                // Soft shadow for elevation
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Brand icon container with gradient and shadow
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // Primary brand gradient
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withValues(alpha: 0.7),
                        ],
                      ),
                      // Prominent shadow for icon elevation
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    // Psychology icon represents AI brain analysis
                    child: const Icon(
                      Icons.psychology,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Main headline with strong typography
                  Text(
                    'AI-Powered Medical Analysis',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Descriptive subtitle with proper line height
                  Text(
                    'Advanced brain tumor detection using cutting-edge AI technology',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.4, // Improved readability
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
