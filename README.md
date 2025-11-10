# Countries App

A Flutter mobile application for browsing, searching, and learning about world countries with favorite management capabilities.

## Features

- **Browse Countries**: View all countries with flags, names, and population
- **Search**: Real-time country search with debouncing
- **Country Details**: Detailed information including area, population, region, timezones
- **Favorites**: Save and manage favorite countries with local persistence
- **Responsive UI**: Clean, modern interface following Material Design

## Tech Stack

- **Flutter 3.29.3** - Dart framework
- **State Management**: BLoC with Cubit
- **HTTP Client**: Dio with caching
- **Local Storage**: Shared Preferences
- **Routing**: Go Router for navigation
- **UI**: Custom theme with shimmer loading states

## Architecture

The app follows a clean architecture pattern with:
- **Data Layer**: API service and local storage
- **Domain Layer**: BLoC for state management
- **Presentation Layer**: Widgets and screens

## Setup

1. **Clone the repository**
- git clone https://github.com/tedtadesse/countries_app
- cd countries_app

2. **Install dependencies**
- flutter pub get

3. **Run the app**
- flutter run

## Project Structure

lib/
├── core/
│   ├── di/           # Dependency injection
│   ├── services/     # API & local storage
│   └── theme/        # App themes & styling
├── data/
│   └── models/       # Data models
└── features/
├── home/         # Country list & search
├── favorites/    # Favorite management
└── country_detail/ # Detailed country view

## API

Uses [REST Countries API](https://restcountries.com) with:
- Minimal data fetching for lists
- Detailed data for individual countries
- Caching for performance

## Build

Generate APK:
- flutter build apk --release
