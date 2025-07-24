import 'dart:io';
import 'package:brisc_detector/home/controllers/home_state.dart';
import 'package:flutter/material.dart';

/// Image selection and display component for the Brain Tumor AI application.
///
/// Handles multiple states:
/// - Empty state: Shows selection prompt with modern design
/// - Image selected: Displays the chosen image in a hero container
/// - Processing state: Shows loading animation over the image
/// - Error state: Handled by parent component
///
/// Features:
/// - Hero animation for smooth transitions
/// - Modern glassmorphism design
/// - Professional loading overlay
/// - Responsive image display
/// - State-aware UI updates
class ImageSection extends StatelessWidget {
  /// The current state of the home page
  final HomeState state;

  const ImageSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Check if an image has been selected or is being processed
    if (state is ImagePickedState ||
        state is ImageClassifyingState ||
        state is ImageClassifiedState ||
        state is ClassificationFailedState) {
      File? imageFile;

      // Extract image file from the appropriate state
      // Using explicit casting for type safety
      if (state is ImagePickedState) {
        imageFile = (state as ImagePickedState).imageFile;
      }
      if (state is ImageClassifyingState) {
        imageFile = (state as ImageClassifyingState).imageFile;
      }
      if (state is ImageClassifiedState) {
        imageFile = (state as ImageClassifiedState).imageFile;
      }
      if (state is ClassificationFailedState) {
        imageFile = (state as ClassificationFailedState).imageFile;
      }

      // Display selected image with hero animation for smooth transitions
      return Hero(
        tag: 'selected-image', // Unique tag for hero transitions
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            // Glassmorphism effect for modern appearance
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
            // Soft shadow for elevation
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // Main image display container
                SizedBox(
                  height: 280, // Fixed height for consistent layout
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover, // Maintain aspect ratio while filling
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.broken_image,
                                  size: 48,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Failed to load image',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Loading overlay when image is being processed
                if (state is ImageClassifyingState)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withValues(
                          alpha: 0.4,
                        ), // Semi-transparent overlay
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Modern loading indicator with background
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation(
                                    theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Loading message with modern styling
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                              child: Text(
                                'Analyzing with AI...',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    // Empty state: Show image selection prompt
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)), // Slide up animation
          child: Opacity(
            opacity: value, // Fade-in effect
            child: Container(
              height: 200, // Fixed height for consistent layout
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                // Glassmorphism design for empty state
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.9),
                    Colors.white.withValues(alpha: 0.1),
                  ],
                ),
                // Dashed-style border to indicate drop zone
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.3),
                  width: 2,
                  style: BorderStyle.solid,
                ),
                // Soft shadow for depth
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Upload icon with background
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primaryContainer.withValues(
                        alpha: 0.3,
                      ),
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 48,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Primary call-to-action text
                  Text(
                    'Select Medical Image',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Descriptive subtitle
                  Text(
                    'Choose an MRI scan for AI analysis',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
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
