E-Fashion Flutter App

Project Version | GitHub license | GitHub last commit | GitHub issues

This repository contains the source code for the E-Fashion Flutter App.
The repository applies Bloc Architecture + Repository Pattern packaging by Features and allows you to create a fashion store app with a lot of features.

📱 App Preview

(No preview video available for now)

Features 🚀

Theming

Material 3 Support

ColorScheme System

Theme Switching (Light - Dark)

Authentication

Login

Register

Forget Password: reset password using email-based OTP

Dynamic Home Feature

Collections

Offers

Brands

Discover (Brands - Products)

Filter & Sort (Category, Gender, Price, Brand)

Shopping

Easy Add To Cart option

Product Details (images, description, price, sizes, colors)

Add/Edit Rating & Review

Products Search

Search by name

Filter by (Category - Brand - Price Range)

Favorites

Save favorite product

Remove favorite product

Cart

Add to cart

Adjust quantities & remove items

Calculate total order amount

Checkout & Payment

Secure checkout with Paymob

Payment with card

User Profile

Profile with (Name, Picture, Email, Location, Order History)

Update profile (picture, name, email, phone, password, location)

Location (Google Maps)

Set/change current location

Real-Time Chat

Customer support chat with SignalR

Notifications

Notifications list

Chat support push notifications

Prerequisites

Before running the app, ensure you have:

Android Studio (2022.2.1 or higher) or VS Code

Flutter 3.13 & Dart 3.0.6 or higher

E-Fashion BackEnd Repository

Getting Started

Clone backend repo and follow README.

Clone this repo:

git clone https://github.com/Abdullah-3hmed/E-Fashion_Flutter.git


Open project in Android Studio or VS Code

Install dependencies:

flutter pub get


Add your Google Maps key to AndroidManifest.xml:

<meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR_GOOGLE_MAPS_KEY"/>


Connect to Firebase project (ensure Firebase_options.dart + google-services.json exist).

Run app:

flutter run

Important Used Packages

Flutter_Screen_Util

Flutter_bloc

Bloc_Concurrency

RxDart

Dartz

Intl

Firebase_Messaging

Flutter_Local_Notifications

Hive

Auto_Route

Cached_Network_Image

Google_Maps_Flutter

Socket_IO_Client

Permission_handler

Paymob

GetIt

Injectable

Image_Picker

API Usage

The apiUrl is stored in api_constants.dart.

Project Architecture Advantages

Independence from presentation layer

Improved maintainability, modularity, reusability, readability, testability

Bloc/Cubit can use several components without restrictions