import 'package:flutter/material.dart';

/// A modern, animated app bar for the Brain Tumor AI application.
///
/// Features:
/// - Custom height (80px) for premium feel
/// - Slide-down entrance animation with opacity fade
/// - Modern shadows with gradient effects
/// - Rounded bottom corners for contemporary design
/// - Brand icon with medical AI theme
/// - Two-line title structure
class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ModernAppBar({super.key});

  /// Custom app bar height for modern appearance
  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Animated entrance effect for the app bar
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic, // Smooth, natural animation curve
      builder: (context, value, child) {
        // Slide down from top with fade-in effect
        return Transform.translate(
          offset: Offset(0, -20 * (1 - value)), // Slide down animation
          child: Opacity(
            opacity: value, // Fade-in animation
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                // Animated shadow that builds up during entrance
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1 * value),
                    blurRadius: 10 * value, // Shadow grows with animation
                    offset: Offset(0, 2 * value),
                  ),
                ],
                // Modern rounded bottom corners
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.psychology,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Title section with two-line structure
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Main app title with modern typography
                            Text(
                              'Brain Tumor AI',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                                letterSpacing:
                                    -0.5, // Tight letter spacing for modern look
                              ),
                            ),
                            // Descriptive subtitle for context
                            Text(
                              'Medical Analysis Platform',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
