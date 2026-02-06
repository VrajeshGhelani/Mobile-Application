# CareerCoach – Career Roadmap & Guidance App

CareerCoach is a premium Flutter-based mobile application designed to empower students and fresh graduates with structured career guidance. It provides curated roadmaps, skill recommendations, and real-time progress tracking to help users navigate their professional journeys.

## 🌟 Key Features

- **🚀 Interactive Splash Screen**: Smooth entry animations with branding.
- **🔐 Secure Auth Simulation**: Professional Login and Registration flows with robust validation.
- **📊 Dynamic Dashboard**: Personalized greetings and discovery hub for major career domains.
- **🗺️ Expert Roadmaps**: Step-by-step visual guides for Software Dev, Data Science, UI/UX, and Cybersecurity.
- **🏆 Certification Integration**: Intelligent suggestions for professional certificates (Google, Meta, AWS, CompTIA).
- **📈 Progress Tracking**: Comprehensive visualization of completed vs. pending tasks across all domains.
- **👤 Profile & Settings**: Management of user focus and app preferences.

## 🏗️ Technical Architecture

The project follows a **Modified Layered Architecture** (Clean-lite) to ensure scalability and maintainability:

- **routes/**: Centralized navigation management using `go_router`.
- **screens/**: Optimized UI layers for different user interactions.
- **models/**: Strongly typed data representations.
- **services/**: Business logic and data management (Mock API handling).
- **widgets/**: Reusable premium UI components.
- **utils/**: Theme definitions and app-wide constants.

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: Provider (ChangeNotifier)
- **Navigation**: GoRouter
- **Icons**: Lucide Icons
- **Typography**: Google Fonts (Outfit)
- **Local Data**: Mock data structures with simulated network latencies.

## 🚀 Getting Started

1.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
2.  **Run the app**:
    ```bash
    flutter run
    ```

## 📝 University Project Notes
- **Design System**: Follows Material 3 design principles with custom branding.
- **Error Handling**: Implemented context-aware validation and persistent UI state.
- **Performance**: Optimized using `const` constructors and efficient state notification.
