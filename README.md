# eFashion Flutter App
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/Abdullah-3hmed/fashion)

eFashion is a comprehensive e-commerce application for fashion, built with Flutter. It provides a seamless shopping experience with a rich feature set for both users and administrators, including real-time chat support, payment integration, and a full-featured product catalog.

## Key Features

- **User Authentication**: Secure sign-up, login, and password management (forget/reset).
- **Dynamic Home Screen**: Features browsable collections, categories, and special offers.
- **Product Discovery**: Users can discover products by brand or category through intuitive grid and list views.
- **Advanced Search & Filtering**: A powerful search engine with filters for categories, brands, and price range.
- **Product Details**: Complete view of product information, including available colors, sizes, and user-submitted reviews and ratings.
- **Shopping Cart**: A fully functional cart to add, manage, and remove items before checkout.
- **Favorites**: Users can save items to a personal favorites list for later access.
- **Secure Checkout**: Integrated with Paymob for a secure and easy payment process.
- **User Profile Management**: Users can edit their profile details, manage their shipping location via Google Maps, and view their order history.
- **Real-time Chat Support**: Built with SignalR for instant communication between users and support.
- **Admin Chat View**: Admins can view all ongoing user support chats.
- **Push Notifications**: Uses Firebase Cloud Messaging (FCM) to keep users informed about their orders and messages.
- **Theme Support**: Includes both light and dark modes for a personalized user experience.

## Tech Stack & Architecture

This project is built using a modern, scalable architecture to ensure maintainability and high performance.

- **Framework**: Flutter
- **State Management**: BLoC / Cubit for predictable state management, with `hydrated_bloc` for state persistence across app sessions.
- **Architecture**: Feature-first architecture, separating business logic by domain.
- **Routing**: `auto_route` for clean, type-safe, and declarative navigation.
- **Networking**: `dio` for robust HTTP requests, enhanced with `pretty_dio_logger` for easy debugging.
- **Dependency Injection**: `get_it` for decoupling and managing dependencies.
- **Backend Integration**:
   - **Firebase**: For push notifications (FCM).
   - **SignalR**: For real-time chat functionality.
   - **Paymob**: For payment processing.
- **Local Storage**: `flutter_secure_storage` for sensitive data like tokens.
- **UI Libraries**:
   - `cached_network_image` for efficient image loading.
   - `skeletonizer` for slick loading skeletons.
   - `syncfusion_flutter_sliders` for advanced slider controls.
   - `flutter_svg` for vector graphics.

## Project Structure

The project follows a clean, feature-driven directory structure to promote separation of concerns.

```
lib/
├── config/
│   ├── router/         # AutoRoute configuration
│   └── themes/         # Light and dark theme definitions
├── core/
│   ├── enums/
│   ├── error/
│   ├── local/          # Caching and local data storage
│   ├── network/        # Dio setup and API constants
│   ├── notifications/  # FCM and Awesome Notifications setup
│   ├── services/       # Service locators and core services (location, etc.)
│   └── widgets/        # Common reusable widgets
├── features/           # Main application features
│   ├── auth/
│   ├── cart/
│   ├── home/
│   ├── profile/
│   └── ...             # Each feature has its own bloc, data, repos, screens
└── shared/             # Models and widgets shared across features
```

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK (version 3.7.2 or higher)
- An IDE like VS Code or Android Studio

### Installation & Setup

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/abdullah-3hmed/fashion.git
    ```
2.  **Navigate to the project directory:**
    ```sh
    cd fashion
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
4.  **Configure Environment Variables:**
    This project requires API keys for Google Maps and configuration for Firebase.

   -   **Backend API**: The base URL is configured in `lib/core/network/api_constants.dart`. Update this to point to your backend instance.
   -   **Google Maps API Key**:
      -   **Android**: Add your key to `android/app/src/main/AndroidManifest.xml`.
      -   **iOS**: Add your key to `ios/Runner/AppDelegate.swift`.
   -   **Firebase**: The project is pre-configured with a `firebase_options.dart` file. To connect to your own Firebase project, run `flutterfire configure` and replace the existing configuration files (`google-services.json` and `firebase_options.dart`).

5.  **Run the application:**
    ```sh
    flutter run