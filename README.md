# Notes App

A full-stack Flutter notes application built with Firebase Authentication, PHP REST API, and MySQL database.

## About The Project

Notes App is a full-stack mobile application that allows users to create, view, edit, and delete their personal notes.

The application uses **Firebase Authentication** for user authentication, while a **PHP REST API backend** manages users, generates custom API tokens, and handles notes operations using a **MySQL database**.

Each user's notes are connected to their account through a user relationship stored in the database.

---

# System Architecture

The application follows this authentication and data flow:

1. User signs up or logs in using Firebase Authentication.
2. Firebase provides a unique Firebase UID.
3. Flutter sends the Firebase UID to the PHP Backend API.
4. PHP finds or creates the user in MySQL.
5. PHP generates a custom API token and stores it.
6. Flutter uses the token for authenticated API requests.
7. PHP Notes API performs CRUD operations on user notes.

![Firebase PHP Architecture](assets/firebase_php_auth_flow.png)

## Architecture Flow

```
                    ┌──────────────────────┐
                    │    Flutter App       │
                    │  Firebase Auth SDK   │
                    └──────────┬───────────┘
                               │
                               │ 1. SignUp / Login
                               │    Email + Password
                               ▼
                    ┌──────────────────────┐
                    │   Firebase Auth      │
                    │ User Authentication  │
                    └──────────┬───────────┘
                               │
                               │ 2. Get Firebase UID
                               ▼
                    ┌──────────────────────┐
                    │    Flutter App       │
                    │ Send firebase_uid    │
                    │       to API         │
                    └──────────┬───────────┘
                               │
                               │ 3. API Request
                               │    firebase_uid
                               ▼
                    ┌──────────────────────┐
                    │   PHP Backend API    │
                    │ User & Token System  │
                    └──────────┬───────────┘
                               │
                               │ 4. Find / Create User
                               │    using firebase_uid
                               │
                               │ 5. Generate Custom API Token
                               ▼
                    ┌──────────────────────┐
                    │   MySQL Database     │
                    │                      │
                    │ users table          │
                    │ - id                 │
                    │ - firebase_uid       │
                    │ - token              │
                    └──────────┬───────────┘
                               │
                               │ 6. Return Custom API Token
                               ▼
                    ┌──────────────────────┐
                    │    Flutter App       │
                    │ Store API Token      │
                    └──────────┬───────────┘
                               │
                               │ Authenticated Requests
                               │ Authorization: Token
                               ▼
                    ┌──────────────────────┐
                    │   PHP Notes API      │
                    │ CRUD Operations      │
                    └──────────┬───────────┘
                               │
                               │ Get / Add / Edit / Delete
                               │ User Notes
                               ▼
                    ┌──────────────────────┐
                    │   MySQL Database     │
                    │                      │
                    │ notes table          │
                    │ - notes_id           │
                    │ - notes_title        │
                    │ - notes_content      │
                    │ - notes_image        │
                    │ - notes_users        │
                    └──────────────────────┘
```

---

# Features

- User registration and login using Firebase Authentication.
- Firebase UID integration with PHP backend.
- Custom API token generation.
- User session management.
- Create, read, update, and delete notes.
- User-specific notes.
- Image upload for notes.
- PHP REST API backend.
- MySQL database integration.
- State management using Riverpod.
- Local session storage using SharedPreferences.

---

# Database Structure

## Users Table

| Column | Description |
|---|---|
| id | Primary key |
| username | User name |
| email | User email |
| firebase_uid | Firebase Authentication UID |
| token | Custom API token |

## Notes Table

| Column | Description |
|---|---|
| notes_id | Primary key |
| notes_title | Note title |
| notes_content | Note content |
| notes_image | Note image path |
| notes_users | User ID relationship |

---

# Bug Fixes & Updates

- Fixed an issue where notes from a previous account could appear after switching users.
- Updated notes loading logic to refresh user-specific data correctly.
- Improved provider lifecycle handling using `autoDispose`.
- Improved communication between Flutter application and PHP backend.
- Improved user session handling using API tokens.

---

# Technologies Used

- Flutter
- Dart
- Firebase Authentication
- Riverpod
- PHP REST API
- MySQL
- SharedPreferences

---

# Project Structure

```
Flutter App
│
├── Firebase Authentication
│
├── PHP REST API
│   │
│   ├── User Management
│   ├── Token Generation
│   └── Notes CRUD
│
└── MySQL Database
    │
    ├── users table
    │
    └── notes table
```

---

# Getting Started

## Install Flutter dependencies

```bash
flutter pub get
```

## Configure Firebase

Add Firebase configuration:

- Android: `google-services.json`
- Flutter: `firebase_options.dart`

## Configure Backend

Update PHP API URLs inside the Flutter application.

## Run Application

```bash
flutter run
```

---

# Backend Requirements

- PHP 8+
- MySQL Database
- Apache Server (XAMPP / LAMPP)

---

# Future Improvements

- Verify Firebase ID Token inside PHP backend.
- Add API middleware authentication.
- Improve API security.
- Add push notifications.