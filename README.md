# Notes App

A Flutter notes application with a PHP backend and MySQL database.

## About The Project

This project is a notes management application that allows users to create, view, edit, and delete their personal notes. Each user has their own account, and notes are linked to the logged-in user.

## Features

* User registration and login.
* User-specific notes management.
* Add, edit, and delete notes.
* Image upload for notes.
* PHP REST API backend.
* MySQL database integration.
* State management using Riverpod.
* Local user session handling using SharedPreferences.

## Bug Fixes & Updates

* Fixed an issue where notes from a previous account could appear after switching users.
* Updated notes loading logic to refresh user-specific data correctly.
* Improved provider lifecycle handling using `autoDispose` to ensure fresh data is loaded after login changes.

## Technologies Used

* Flutter
* Dart
* Riverpod
* PHP
* MySQL
* SharedPreferences

## Getting Started

To run this project:

1. Clone the repository.
2. Install Flutter dependencies:

```bash
flutter pub get
```

3. Configure the backend API links.
4. Run the application:

```bash
flutter run
```
