# 🌿 Sakeena App

<p align="center">
  <img src="assets/images/sakeena_logo.png" alt="Sakeena Logo" width="120"/>
</p>

<p align="center">
  <strong>A Flutter health-companion application focused on mental wellness, smart scanning, and AI-powered guidance.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/Version-1.0.0-green?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue?style=for-the-badge"/>
</p>

---

## 📖 About

**Sakeena** (سكينة) is a comprehensive health companion mobile application built with Flutter. It empowers users to take control of their wellbeing through AI-assisted features including smart scanning, risk assessment, educational health content, and a conversational AI chat interface — all wrapped in a clean, accessible, and localized UI.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔐 **Authentication** | Secure sign-up, login, and password recovery flows |
| 🧭 **Onboarding** | Guided onboarding experience for new users |
| 🏠 **Home Dashboard** | Centralized hub for all app features |
| 💬 **AI Chat** | Conversational AI assistant for health queries |
| 📚 **Health Education** | Curated educational content and health articles |
| 📋 **Exam History** | Track and review past health assessments |
| ⚠️ **Risk Assessment** | Personalized health risk evaluation questionnaires |
| 🩺 **Self Scanning** | Camera-based self-examination guided tool |
| 🔬 **Smart Scan** | AI-powered smart scanning feature |
| 📖 **Health Guide** | Step-by-step health guides and tips |
| 🔔 **Notifications** | Local push notifications and reminders |
| 👤 **Account Management** | Profile, settings, and data management |

---

## 🏗️ Architecture

The app follows **Clean Architecture** principles with a **feature-first** folder structure.

```
lib/
├── main.dart                   # App entry point
├── constsnt.dart               # Global constants
├── core/                       # Shared core layer
│   ├── app/                    # Root app widget (SakeenaApp)
│   ├── database/               # Local storage helpers
│   ├── di/                     # Dependency injection (get_it)
│   ├── errors/                 # Failure & error models
│   ├── network/                # Dio HTTP client & interceptors
│   ├── resources/              # Colors, strings, themes
│   ├── services/               # Notification, permissions, etc.
│   ├── utils/                  # Router (go_router), helpers
│   └── widgets/                # Reusable UI components
└── features/                   # Feature modules
    ├── auth/                   # Authentication
    ├── onboarding/             # Onboarding screens
    ├── splash/                 # Splash screen
    ├── home/                   # Home dashboard
    ├── chat/                   # AI Chat (data / domain / presentation)
    ├── education/              # Health education
    ├── exam_history/           # Exam history
    ├── health_guide/           # Health guides
    ├── notifications/          # Notifications
    ├── risk_assessment/        # Risk assessment
    ├── self_scaning/           # Self-scanning
    ├── smart_acan/             # Smart scan
    └── account/                # User account
```

Each feature follows the **3-layer pattern**:
- `data/` — repositories, data sources, models
- `domain/` — use cases & entities *(where applicable)*
- `presentation/` / `ui/` / `logic/` — BLoC, screens, widgets

---

## 🛠️ Tech Stack

### State Management
- **flutter_bloc** `^9.1.1` — BLoC pattern for predictable state management

### Navigation
- **go_router** `^17.2.2` — Declarative routing with deep-link support

### Networking
- **dio** `^5.9.2` — HTTP client for API communication
- **pretty_dio_logger** `^1.4.0` — Readable network request/response logs

### Dependency Injection
- **get_it** `^9.2.1` — Service locator for DI

### Functional Programming
- **dartz** `^0.10.1` — `Either` type for clean error handling

### UI & Design
- **flutter_screenutil** `^5.9.3` — Adaptive screen sizing
- **google_fonts** `^8.0.2` — Typography
- **loading_animation_widget** `^1.3.0` — Loading indicators
- **lottie** `^3.3.3` — Lottie animations

### Device Features
- **camera** `^0.12.0+1` — Camera access for scanning features
- **image_picker** `^1.2.1` — Gallery & camera image selection
- **speech_to_text** `^7.3.0` — Voice input support
- **permission_handler** `^12.0.1` — Runtime permission management

### Notifications & Storage
- **flutter_local_notifications** `17.2.4` — Local push notifications
- **timezone** `^0.9.4` — Timezone-aware scheduling
- **shared_preferences** `^2.5.5` — Lightweight local key-value storage

### Localization
- **flutter_localization** `^0.4.0` — Multi-language support
- **flutter_localizations** *(Flutter SDK)* — Internationalization delegates

### Utilities
- **package_info_plus** `^8.3.0` — App version detection (auto-clears cache on update)
- **url_launcher** `^6.3.2` — Open URLs in browser
- **image** `^4.8.0` — Image processing

---

## 🌍 Localization

Sakeena supports **multiple languages** via `flutter_localization`. The app detects and respects the device locale, with Arabic as a primary supported language.

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.0.0 <4.0.0`
- Dart `>=3.0.0 <4.0.0`
- Android Studio / VS Code with Flutter & Dart plugins
- A connected device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/HamdiElsherpeni/sakeena_app.git
   cd sakeena_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build

```bash
# Android APK
flutter build apk --release

# iOS (requires macOS)
flutter build ios --release
```

---

## 📱 Supported Platforms

| Platform | Status |
|---|---|
| Android | ✅ Supported |
| iOS | ✅ Supported |
| Web | ⚙️ In Progress |
| Windows | ⚙️ In Progress |
| macOS | ⚙️ In Progress |
| Linux | ⚙️ In Progress |

---

## 🔔 Notifications

The app uses `flutter_local_notifications` with timezone-aware scheduling. Notifications are initialized at app startup and cleared/reset automatically when the app version changes.

---

## 🔒 Permissions

The app may request the following permissions depending on the feature used:

- **Camera** — Smart Scan & Self Scanning features
- **Microphone** — Speech-to-text in the AI Chat
- **Storage** — Image Picker for profile & health uploads
- **Notifications** — Health reminders and alerts

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'feat: add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

This project is private and not published to pub.dev.

---

<p align="center">
  Made with ❤️ using Flutter
</p>
