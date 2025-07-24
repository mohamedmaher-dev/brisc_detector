# 🧠 BRISC Detector - Brain Tumor Classification App

A Flutter-based mobile application that uses AI to classify brain tumor types from MRI images using TensorFlow Lite. The app features a modern, animated interface with robust error handling and can detect four types of conditions: Glioma, Meningioma, Pituitary Tumor, and No Tumor.

## ✨ Features

### 🎯 Core Functionality

- **🔬 AI-Powered Classification**: Uses a trained TensorFlow Lite model for accurate brain tumor detection
- **📸 Multiple Input Sources**: Support for both camera capture and gallery image selection
- **📊 Detailed Analysis**: Provides confidence scores for all tumor types with visual progress indicators
- **⚡ Real-time Processing**: On-device inference for fast, private analysis
- **🛡️ Privacy-First**: All processing happens locally on the device
- **📱 Cross-Platform**: Built with Flutter for iOS and Android compatibility

### 🎨 Modern UI/UX

- **✨ Animated Background**: Dynamic geometric shapes with smooth floating and rotating animations
- **🌟 Glassmorphism Design**: Modern frosted glass effects with gradient overlays
- **🎭 Hero Animations**: Smooth transitions between different app states
- **📱 Responsive Layout**: Adaptive design that works across different screen sizes
- **🔄 Loading States**: Professional loading indicators with contextual messages
- **⚠️ Enhanced Error Handling**: User-friendly error messages with recovery options

### 🛠️ Technical Improvements

- **🔍 Image Validation**: Comprehensive file existence and format verification
- **📏 Smart Resizing**: Automatic image optimization for better performance
- **💾 Memory Management**: Efficient image processing to prevent crashes
- **🎯 State Management**: Robust BLoC pattern implementation with proper error propagation
- **🧪 Error Recovery**: Graceful handling of edge cases and network issues

## 🏥 Supported Classifications

| Tumor Type          | Description                                                    | Color Code | Confidence Display |
| ------------------- | -------------------------------------------------------------- | ---------- | ------------------ |
| **Glioma**          | A type of brain tumor that occurs in the brain and spinal cord | 🔴 Red     | Progress indicator |
| **Meningioma**      | A tumor that arises from the meninges                          | 🟠 Orange  | Progress indicator |
| **Pituitary Tumor** | A tumor that forms in the pituitary gland                      | 🔵 Blue    | Progress indicator |
| **No Tumor**        | Healthy brain tissue with no detectable tumor                  | 🟢 Green   | Progress indicator |

## 🛠️ Technical Stack

- **Framework**: Flutter 3.8.1+
- **Language**: Dart
- **AI/ML**: TensorFlow Lite
- **State Management**: BLoC Pattern
- **Image Processing**: Dart Image Library
- **Animations**: Flutter Animations API with CustomPainter
- **Architecture**: Clean Architecture with Service Layer

## 📱 App Interface

### 🎨 Visual Components

- **Modern Header**: Animated glassmorphism design with brand icon
- **Image Section**: Hero animations with loading states and error handling
- **Results Display**: Color-coded confidence meters with smooth animations
- **Action Buttons**: Gradient-styled buttons with hover effects
- **Background**: Dynamic animated shapes (circles, triangles, squares, hexagons)

### 🎭 Animation Features

- **Floating Elements**: Subtle up/down movement (4-second cycles)
- **Rotating Shapes**: Continuous geometric rotations (20-second cycles)
- **Fade Transitions**: Smooth opacity changes between states
- **Scale Animations**: Entrance effects for UI components
- **Custom Painting**: Hardware-accelerated background rendering

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android device or emulator / iOS simulator

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd brisc_detector
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Verify your Flutter installation**

   ```bash
   flutter doctor
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📖 Usage

### 🎯 Step-by-Step Guide

1. **🚀 App Launch**:

   - Open BRISC Detector on your device
   - Enjoy the animated background while the app initializes

2. **🤖 Model Loading**:

   - The app automatically loads the AI model
   - Visual loading indicator shows progress
   - First launch may take a few seconds

3. **📸 Image Selection**:
   Choose your preferred input method:

   - **📷 Camera**: Capture a new MRI image with real-time preview
   - **🖼️ Gallery**: Select an existing image from your device storage

4. **🔄 Processing**:

   - Selected image displays with smooth hero animation
   - Loading overlay appears during AI analysis
   - Progress indicators show processing status

5. **📊 Results**:

   - Primary classification with confidence percentage
   - Detailed breakdown of all four predictions
   - Color-coded visual indicators with animations
   - Confidence meters with smooth progress animations

6. **🔄 Reset**:
   - Use "New Analysis" button to clear results
   - Smooth transition back to selection state

### 💡 Tips for Best Results

- Use clear, high-contrast MRI images
- Ensure good lighting for camera captures
- Center the brain region in the image
- Use standard MRI formats (JPEG, PNG)

## 🔬 Model Information

- **Model Type**: TensorFlow Lite (`.tflite`)
- **Input Size**: 224x224x3 (RGB)
- **Output**: 4-class classification probabilities
- **Preprocessing**: Automatic image resizing and normalization
- **Inference**: On-device processing for privacy and speed
- **Error Handling**: Comprehensive validation and recovery

### Model Files

- `assets/model_unquant.tflite` - The trained classification model
- `assets/labels.txt` - Class labels mapping

## 🏗️ Architecture

The app follows clean architecture principles with enhanced error handling:

```
lib/
├── core/
│   ├── services/
│   │   └── tflite_service.dart          # Enhanced TensorFlow Lite operations
│   └── utils/
│       └── assets_manager.dart          # Asset path management
├── home/
│   ├── controllers/
│   │   ├── home_bloc.dart              # Robust business logic with error handling
│   │   ├── home_event.dart             # User interaction events
│   │   └── home_state.dart             # Comprehensive app states
│   ├── data/
│   │   └── models/
│   │       ├── brisc_status.dart       # Tumor type enumeration
│   │       └── classification_result.dart # Enhanced result model
│   └── views/
│       ├── home_view.dart              # Main UI with animated background
│       └── widgets/
│           ├── animated_background.dart # Dynamic shape animations
│           ├── modern_header.dart      # Glassmorphism header design
│           ├── image_section.dart      # Enhanced image display with error handling
│           ├── results_section.dart    # Animated results display
│           ├── action_buttons.dart     # Modern button components
│           └── modern_app_bar.dart     # Styled app bar
└── main.dart                           # App entry point
```

## 📦 Dependencies

### Core Dependencies

- `flutter` - UI framework with animation support
- `tflite_flutter: ^0.10.4` - TensorFlow Lite inference
- `image_picker: ^1.0.7` - Enhanced image selection
- `image: ^4.1.7` - Image processing and manipulation
- `flutter_bloc: ^8.1.4` - State management with error handling

### Development Dependencies

- `flutter_test` - Testing framework
- `flutter_lints: ^5.0.0` - Linting rules

## 🔧 Development

### 🎨 Customizing Animations

```dart
// Modify animation durations in animated_background.dart
_floatingController = AnimationController(
  duration: const Duration(seconds: 4), // Floating speed
  vsync: this,
);

_rotationController = AnimationController(
  duration: const Duration(seconds: 20), // Rotation speed
  vsync: this,
);
```

### 🎯 Adding New Features

1. **New Classification Types**: Update the `BriscStatus` enum and retrain the model
2. **UI Improvements**: Modify widgets following Material Design 3 guidelines
3. **Animation Enhancements**: Extend `BackgroundShapesPainter` for new effects
4. **Performance Optimization**: Enhance the `TFLiteService` for better inference speed

### 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart

# Test error handling
flutter test test/error_handling_test.dart
```

### 📱 Building for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (recommended)
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 🚨 Error Handling

The app includes comprehensive error handling for:

- **Image Loading Failures**: Shows broken image indicator with retry option
- **Model Loading Issues**: Clear error messages with reload functionality
- **File Access Problems**: Validates file existence and permissions
- **Memory Constraints**: Automatic image resizing to prevent crashes
- **Network Issues**: Graceful degradation for offline usage
- **Invalid File Formats**: User-friendly format validation messages

## ⚠️ Medical Disclaimer

**⚠️ IMPORTANT: This application is for educational and research purposes only. It should not be used as a substitute for professional medical diagnosis or treatment. Always consult with qualified healthcare professionals for medical decisions. The AI model's predictions should be verified by medical experts.**

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### 🎨 Contributing Guidelines

- Follow Flutter/Dart style guidelines
- Maintain the existing animation design language
- Include error handling for new features
- Add appropriate documentation
- Test on multiple devices and screen sizes

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- TensorFlow team for the TensorFlow Lite framework
- Flutter team for the excellent cross-platform framework and animation APIs
- Medical imaging research community for advancing AI in healthcare
- Material Design team for design inspiration

## 📞 Support

For support, please open an issue in the GitHub repository or contact the development team.

### 🐛 Known Issues

If you encounter any issues:

1. Check Flutter doctor for environment setup
2. Ensure device has sufficient memory for image processing
3. Verify model files are properly included in assets
4. Test with different image formats if classification fails

## 🔄 Version History

- **v2.0.0**: Added animated background, enhanced error handling, modern UI
- **v1.0.0**: Initial release with basic classification functionality

---

**Built with ❤️ using Flutter, TensorFlow Lite, and Modern Animation APIs**

_Experience the future of medical AI with beautiful, responsive design_
