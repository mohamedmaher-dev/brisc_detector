import 'package:brisc_detector/home/controllers/home_bloc.dart';
import 'package:brisc_detector/home/controllers/home_event.dart';
import 'package:brisc_detector/home/controllers/home_state.dart';
import 'package:brisc_detector/home/views/widgets/modern_app_bar.dart';
import 'package:brisc_detector/home/views/widgets/modern_header.dart';
import 'package:brisc_detector/home/views/widgets/image_section.dart';
import 'package:brisc_detector/home/views/widgets/results_section.dart';
import 'package:brisc_detector/home/views/widgets/action_buttons.dart';
import 'package:brisc_detector/home/views/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main home view for the Brain Tumor AI application.
///
/// This is the primary screen that orchestrates all major components:
/// - Modern app bar with branding and navigation
/// - Welcome header with app description
/// - Image selection and display area
/// - AI analysis results presentation
/// - Action buttons for user interactions
///
/// Features:
/// - BLoC pattern for state management
/// - Modular widget composition
/// - Gradient background design
/// - Responsive layout with proper spacing
/// - Clean separation of concerns
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide BLoC to widget tree and initialize with model loading
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadModelEvent()),
      child: const _HomeViewBody(),
    );
  }
}

/// Private body widget that builds the main UI structure.
///
/// Separated from HomeView to maintain clean BLoC provider setup
/// and avoid rebuilding the provider on every state change.
class _HomeViewBody extends StatelessWidget {
  const _HomeViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom app bar with modern design and animations
      appBar: const ModernAppBar(),
      extendBodyBehindAppBar: false,
      body: AnimatedBackground(
        // BLoC builder to rebuild UI based on state changes
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            // Scrollable content that fills the screen
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      kToolbarHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Welcome header with app branding and description
                      const ModernHeader(),
                      const SizedBox(height: 32),

                      // Image selection and display component
                      // Handles empty state, selected image, and processing overlay
                      ImageSection(state: state),
                      const SizedBox(height: 32),

                      // AI analysis results display
                      // Shows detailed classification results or error states
                      ResultsSection(state: state),
                      const SizedBox(height: 32),

                      // Action buttons for user interactions
                      // Gallery, camera, retry, and clear functionality
                      ActionButtons(state: state),
                      const SizedBox(height: 20), // Bottom padding
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
