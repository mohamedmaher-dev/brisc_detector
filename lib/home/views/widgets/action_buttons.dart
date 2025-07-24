import 'package:brisc_detector/home/controllers/home_bloc.dart';
import 'package:brisc_detector/home/controllers/home_event.dart';
import 'package:brisc_detector/home/controllers/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Action buttons component for image selection and app control.
///
/// Handles multiple UI states:
/// - Model loading: Shows initialization progress
/// - Model failed: Displays error with retry option
/// - Image picking: Shows selection progress
/// - Ready: Shows gallery/camera buttons
/// - Results available: Adds clear/new analysis option
///
/// Features:
/// - State-aware button visibility and styling
/// - Modern button design with gradients and shadows
/// - Animated entrance effects
/// - Professional loading indicators
/// - Error handling with retry functionality
class ActionButtons extends StatelessWidget {
  /// The current application state
  final HomeState state;

  const ActionButtons({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<HomeBloc>();

    // Show loading indicator when AI model is initializing
    if (state is ModelLoadingState) {
      return Center(
        child: Column(
          children: [
            // Modern loading container with gradient background
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                    theme.colorScheme.primary.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Loading message
            Text(
              'Initializing AI Model...',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      );
    }

    // Show error state when model fails to load
    if (state is ModelLoadFailedState) {
      return Column(
        children: [
          // Error container with red-themed styling
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  Colors.red.withValues(alpha: 0.1),
                  Colors.red.withValues(alpha: 0.05),
                ],
              ),
              border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                // Error icon
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                // Error title
                Text(
                  'Failed to initialize AI model',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Error message from the failed state
                Text(
                  (state as ModelLoadFailedState).error,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Retry button with modern styling
          _ModernButton(
            onPressed: () => bloc.add(LoadModelEvent()),
            icon: Icons.refresh,
            label: 'Retry',
            isPrimary: true,
            theme: theme,
          ),
        ],
      );
    }

    // Show loading indicator when image picker is opening
    if (state is ImagePickingState) {
      return Center(
        child: Column(
          children: [
            // Loading container similar to model loading
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                    theme.colorScheme.primary.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Picker loading message
            Text(
              'Opening image selector...',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      );
    }

    // Show main action buttons when ready for user interaction
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)), // Slide up animation
          child: Opacity(
            opacity: value, // Fade-in effect
            child: Column(
              children: [
                // Primary action buttons row
                Row(
                  children: [
                    // Gallery selection button (primary style)
                    Expanded(
                      child: _ModernButton(
                        onPressed: () => bloc.add(PickImageFromGalleryEvent()),
                        icon: Icons.photo_library_outlined,
                        label: 'Gallery',
                        isPrimary: true, // Prominent styling
                        theme: theme,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Camera capture button (secondary style)
                    Expanded(
                      child: _ModernButton(
                        onPressed: () => bloc.add(PickImageFromCameraEvent()),
                        icon: Icons.camera_alt_outlined,
                        label: 'Camera',
                        isPrimary: false, // Outlined styling
                        theme: theme,
                      ),
                    ),
                  ],
                ),
                // Show additional options when results are available
                if (state is ImageClassifiedState ||
                    state is ClassificationFailedState) ...[
                  const SizedBox(height: 16),
                  // Clear results button for new analysis
                  _ModernButton(
                    onPressed: () => bloc.add(ClearResultsEvent()),
                    icon: Icons.refresh,
                    label: 'New Analysis',
                    isPrimary: false,
                    theme: theme,
                    fullWidth: true, // Full width for prominence
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Modern styled button widget with gradient and shadow effects.
///
/// Features:
/// - Primary vs secondary styling
/// - Gradient backgrounds for primary buttons
/// - Outlined design for secondary buttons
/// - Modern shadows and hover effects
/// - Consistent sizing and padding
/// - Icon + text layout
class _ModernButton extends StatelessWidget {
  /// Callback function when button is pressed
  final VoidCallback onPressed;

  /// Icon to display in the button
  final IconData icon;

  /// Text label for the button
  final String label;

  /// Whether this is a primary (filled) or secondary (outlined) button
  final bool isPrimary;

  /// Theme data for consistent styling
  final ThemeData theme;

  /// Whether button should take full width
  final bool fullWidth;

  const _ModernButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.isPrimary,
    required this.theme,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      height: 56, // Consistent button height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // Gradient background for primary buttons
        gradient: isPrimary
            ? LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withValues(alpha: 0.8),
                ],
              )
            : null,
        // Border for secondary buttons
        border: !isPrimary
            ? Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
                width: 1.5,
              )
            : null,
        // Different shadows for primary vs secondary buttons
        boxShadow: isPrimary
            ? [
                // Prominent shadow for primary buttons
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                // Subtle shadow for secondary buttons
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Button icon with appropriate color
                Icon(
                  icon,
                  color: isPrimary ? Colors.white : theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                // Button label with matching color
                Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isPrimary ? Colors.white : theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
