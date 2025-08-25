# E-Fashion Flutter App

Project Version | GitHub license | GitHub last commit | GitHub issues

This repository contains the source code for the **E-Fashion Flutter App**.  
The repository applies **Bloc Architecture + Repository Pattern** packaging by Features and allows you to create a fashion store app with a lot of features.

## 📱 App Preview

(No preview video available for now)

## Features 🚀

### Theming
- Material 3 Support
- ColorScheme System
- Theme Switching (Light - Dark)

### Authentication
- Login
- Register
- Forget Password: reset password using email-based OTP

### Dynamic Home Feature
- Collections
- Offers
- Brands
- Discover (Brands - Products)
- Filter & Sort (Category, Gender, Price, Brand)

### Shopping
- Easy Add To Cart option
- Product Details (images, description, price, sizes, colors)
- Add/Edit Rating & Review

### Products Search
- Search by name
- Filter by (Category - Brand - Price Range)

### Favorites
- Save favorite product
- Remove products from product list

### Cart
- Add to cart
- Adjust quantities & remove items
- Calculate total order amount

### Checkout & Payment
- Secure checkout with **Paymob**
- Payment with card

### User Profile
- Profile with (Name, Picture, Email, Location, Order History)
- Update profile (picture, name, email, phone, password, location)

### Location (Google Maps)
- Set/change current location

### Real-Time Chat
- Customer support chat with **SignalR**

### Notifications
- Notifications list
- Chat support push notifications

---

## Prerequisites

Before running the app, ensure you have:

- Android Studio (2022.2.1 or higher) or VS Code
- Flutter 3.13 & Dart 3.0.6 or higher

---

## Getting Started

1. Clone backend repo and follow README.
2. Clone this repo:

   ```bash
   git clone https://github.com/Abdullah-3hmed/E-Fashion_Flutter.git
   ```

3. Open project in Android Studio or VS Code
4. Install dependencies:

   ```bash
   flutter pub get
   ```

5. Add your Google Maps key to `AndroidManifest.xml`:

   ```xml
   <meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR_GOOGLE_MAPS_KEY"/>
   ```

6. Connect to Firebase project (ensure `Firebase_options.dart` + `google-services.json` exist).
7. Run app:

   ```bash
   flutter run
   ```

---

## Important Used Packages

- auto_route
- get_it
- flutter_svg
- pinput
- carousel_slider
- smooth_page_indicator
- font_awesome_flutter
- solar_icons
- flutter_rating_bar
- easy_stepper
- iconsax
- syncfusion_flutter_sliders
- intl
- dio
- pretty_dio_logger
- equatable
- dartz
- flutter_bloc
- bloc
- firebase_core
- firebase_messaging
- awesome_notifications
- flutter_dotenv
- flutter_secure_storage
- flutter_spinkit
- fluttertoast
- cached_network_image
- hydrated_bloc
- path_provider
- image_picker
- multi_payment_gateway
- google_maps_flutter
- location
- geocoding
- skeletonizer
- path_drawing
- dotted_dashed_line
- collection
- rxdart
- bloc_concurrency
- flutter_native_splash
- internet_connection_checker_plus
- signalr_netcore

---

## API Usage

- The `apiUrl` is stored in `api_constants.dart`.

---

## Project Architecture Advantages

- Independence from presentation layer  
- Improved maintainability, modularity, reusability, readability, testability  
- Bloc/Cubit can use several components without restrictions  

---

## License

Licensed under the **Apache License**.  
Feel free to use, modify, and distribute.  

---

## Contact

📧 Email: **abdullhahmed107@gmail.com**  
🐙 GitHub: [Abdullah-3hmed](https://github.com/Abdullah-3hmed)
