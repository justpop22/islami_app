# Islami - Flutter App

## Overview
Islami is a comprehensive Islamic companion application built with Flutter.[cite: 1] It provides users with a digital interface to read the Holy Quran, browse Hadiths, utilize a digital Sebha, and listen to live Islamic radio and Quranic reciters.[cite: 1]

## Key Features
*   **Quran Reader**: Access all 114 Suras with verse-by-verse formatting.[cite: 1] Includes a real-time search functionality by Arabic or English names and a "Most Recently Read" section for quick access.[cite: 1]
*   **Hadith Collection**: Browse a collection of Hadiths presented through an interactive, visually appealing carousel slider.[cite: 1]
*   **Interactive Sebha**: A digital rosary featuring animated rotation that responds to user taps.[cite: 1] It automatically cycles through different Azkar and saves your count progress locally so you never lose your place.[cite: 1]
*   **Live Radio & Reciter Audio**: Stream live Islamic radio stations and specific reciter audio directly from the MP3Quran API.[cite: 1] Features a fully integrated audio player with play, pause, stop, and mute controls.[cite: 1]

## Tech Stack & Architecture
*   **Framework**: Flutter & Dart[cite: 1]
*   **State Management**: `Provider` (specifically used for centralized audio playback and state control).[cite: 1]
*   **Networking**: `http` package for making RESTful API calls to fetch radio and reciter data.[cite: 1]
*   **Audio Integration**: `just_audio` for handling background streaming, playback controls, and volume adjustments.[cite: 1]
*   **Local Storage**: `shared_preferences` utilized for caching search history and persisting the user's Sebha progress.[cite: 1]
*   **UI/UX**: Custom dark theme implementation, `flutter_svg` for crisp iconography, and `carousel_slider` for fluid content navigation.[cite: 1]
