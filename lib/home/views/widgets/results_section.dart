import 'package:brisc_detector/home/controllers/home_state.dart';
import 'package:brisc_detector/home/data/models/brisc_status.dart';
import 'package:flutter/material.dart';

/// Results display component for AI brain tumor classification.
///
/// Handles multiple result states:
/// - Success: Shows detailed analysis with animated progress bars
/// - Error: Displays error message with appropriate styling
/// - Empty: Returns empty widget (no results to show)
///
/// Features:
/// - Animated entrance with scale and fade effects
/// - Color-coded results based on tumor type
/// - Animated progress bars for confidence visualization
/// - Detailed breakdown of all classification probabilities
/// - Staggered animations for list items
/// - Professional medical UI design
class ResultsSection extends StatelessWidget {
  /// The current state containing classification results
  final HomeState state;

  const ResultsSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Display classification results if analysis completed successfully
    if (state is ImageClassifiedState) {
      final result = (state as ImageClassifiedState).result;

      // Animated entrance for results with scale and fade effect
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 800),
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.8 + (0.2 * value), // Scale from 80% to 100%
            child: Opacity(
              opacity: value, // Fade-in animation
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  // Glassmorphism background
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.9),
                      Colors.white.withValues(alpha: 0.1),
                    ],
                  ),
                  // Subtle border for definition
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                  // Color-coded shadow based on detected tumor type
                  boxShadow: [
                    BoxShadow(
                      color: result.tumorType.color.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header section with analytics icon and title
                      Row(
                        children: [
                          // Icon container with gradient background
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  theme.colorScheme.primary,
                                  theme.colorScheme.primary.withValues(
                                    alpha: 0.7,
                                  ),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.analytics,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Section title
                          Text(
                            'AI Analysis Results',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Primary result display with prominent styling
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // Color-coded gradient based on tumor type
                          gradient: LinearGradient(
                            colors: [
                              result.tumorType.color.withValues(alpha: 0.1),
                              result.tumorType.color.withValues(alpha: 0.05),
                            ],
                          ),
                          // Colored border matching tumor type
                          border: Border.all(
                            color: result.tumorType.color.withValues(
                              alpha: 0.3,
                            ),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Top row with tumor type and confidence percentage
                            Row(
                              children: [
                                // Color indicator dot with gradient and shadow
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        result.tumorType.color,
                                        result.tumorType.color.withValues(
                                          alpha: 0.7,
                                        ),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: result.tumorType.color
                                            .withValues(alpha: 0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Tumor type name
                                Expanded(
                                  child: Text(
                                    result.tumorType.name,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                // Confidence percentage badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                      colors: [
                                        result.tumorType.color,
                                        result.tumorType.color.withValues(
                                          alpha: 0.8,
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: Text(
                                    '${(result.confidence * 100).toStringAsFixed(1)}%',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Animated progress bar for primary result
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: result.confidence),
                              duration: const Duration(milliseconds: 1000),
                              builder: (context, animatedValue, child) {
                                return Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: result.tumorType.color.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor:
                                        animatedValue, // Animated width
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        gradient: LinearGradient(
                                          colors: [
                                            result.tumorType.color,
                                            result.tumorType.color.withValues(
                                              alpha: 0.8,
                                            ),
                                          ],
                                        ),
                                        // Shadow for progress bar depth
                                        boxShadow: [
                                          BoxShadow(
                                            color: result.tumorType.color
                                                .withValues(alpha: 0.3),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Detailed analysis section header
                      Text(
                        'Detailed Analysis',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // List of all tumor types with their confidence scores
                      // Using staggered animations for engaging presentation
                      ...BriscStatus.values.asMap().entries.map((entry) {
                        final index = entry.key;
                        final status = entry.value;
                        final confidence = result.allPredictions[status] ?? 0.0;

                        // Staggered entrance animation for each item
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(
                            milliseconds: 400 + (index * 100),
                          ), // Delayed start
                          builder: (context, animValue, child) {
                            return Transform.translate(
                              offset: Offset(
                                20 * (1 - animValue),
                                0,
                              ), // Slide in from right
                              child: Opacity(
                                opacity: animValue,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    // Subtle background color for each item
                                    color: status.color.withValues(alpha: 0.05),
                                    border: Border.all(
                                      color: status.color.withValues(
                                        alpha: 0.1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Status color indicator
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              status.color,
                                              status.color.withValues(
                                                alpha: 0.7,
                                              ),
                                            ],
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Tumor type name
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          status.name,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      // Animated progress bar for individual confidence
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          height: 6,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
                                            color: status.color.withValues(
                                              alpha: 0.2,
                                            ),
                                          ),
                                          child: TweenAnimationBuilder<double>(
                                            tween: Tween(
                                              begin: 0.0,
                                              end: confidence,
                                            ),
                                            duration: const Duration(
                                              milliseconds: 800,
                                            ),
                                            builder:
                                                (
                                                  context,
                                                  animatedConfidence,
                                                  child,
                                                ) {
                                                  return FractionallySizedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    widthFactor:
                                                        animatedConfidence,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              3,
                                                            ),
                                                        gradient:
                                                            LinearGradient(
                                                              colors: [
                                                                status.color,
                                                                status.color
                                                                    .withValues(
                                                                      alpha:
                                                                          0.8,
                                                                    ),
                                                              ],
                                                            ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Confidence percentage
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          '${(confidence * 100).toStringAsFixed(1)}%',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: status.color,
                                              ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    // Display error state if classification failed
    if (state is ClassificationFailedState) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          // Error-themed gradient background
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red.withValues(alpha: 0.1),
              Colors.red.withValues(alpha: 0.05),
            ],
          ),
          // Red border for error indication
          border: Border.all(
            color: Colors.red.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Error icon with background
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withValues(alpha: 0.1),
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              // Error title
              Text(
                'Analysis Failed',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Error message from the failed state
              Text(
                (state as ClassificationFailedState).error,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Return empty widget if no results to display
    return const SizedBox.shrink();
  }
}
