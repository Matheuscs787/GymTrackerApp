# 🏋️ GymTracker

A fast and minimal **iOS workout tracking app** built with **SwiftUI**.

![Swift](https://img.shields.io/badge/Swift-5-orange)
![iOS](https://img.shields.io/badge/iOS-17+-blue)
![SwiftUI](https://img.shields.io/badge/SwiftUI-Native-green)
![Architecture](https://img.shields.io/badge/architecture-MVVM-blue)
![Persistence](https://img.shields.io/badge/database-SwiftData-purple)
![Status](https://img.shields.io/badge/status-in--development-yellow)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

GymTracker is a **native iOS workout tracking app** designed to make
logging workouts simple, fast, and distraction-free.

The app allows users to register workouts, track sets and weights, and
view training history to monitor strength progress over time.

The focus of the project is **speed and usability during workouts**,
minimizing friction when logging exercises at the gym.

------------------------------------------------------------------------

# 🎬 Demo

*Coming soon*

Example usage preview:

Workout List → Start Workout → Log Sets → Finish Session → View History

Future README improvements may include:

-   GIF demo
-   UI screenshots
-   App walkthrough video

------------------------------------------------------------------------

# 📱 Features

-   Create and manage **workout routines**
-   Track **sets, weight, and repetitions**
-   Support for **training to failure**
-   Configure **rest intervals between sets**
-   Automatically display **last weight used**
-   Workout **history tracking**
-   Edit or delete past workout records
-   Clean and minimal **gym-friendly UI**
-   Native performance using **SwiftUI**

------------------------------------------------------------------------

# 🧠 Design Principles

GymTracker was designed around three main principles:

### ⚡ Speed

Logging a set should take **less than 2 seconds**.

### 🧩 Simplicity

Minimal UI to avoid distractions during workouts.

### 📈 Progress Visibility

Users can easily compare current performance with previous sessions.

------------------------------------------------------------------------

# 🏗 Architecture

The project follows a **lightweight MVVM-inspired architecture**,
keeping UI, models, and utilities well separated.

    GymTrackerApp
    │
    ├── Models
    │   ├── WorkoutSession.swift
    │   ├── ExerciseSession.swift
    │   └── SetEntry.swift
    │
    ├── Views
    │   ├── Workouts
    │   │   ├── WorkoutListView.swift
    │   │   └── WorkoutDetailView.swift
    │   │
    │   ├── Sessions
    │   │   ├── WorkoutSessionView.swift
    │   │   └── WorkoutSessionDetailView.swift
    │   │
    │   └── Components
    │       └── SetEntryRowView.swift
    │
    ├── Utils
    │   ├── Formatters.swift
    │   └── Extensions.swift
    │
    └── Assets

------------------------------------------------------------------------

# 📦 Core Concepts

### WorkoutSession

Represents a **full workout performed by the user**.

Stores: - workout name - execution date - exercises performed -
completion status

------------------------------------------------------------------------

### ExerciseSession

Represents an **exercise inside a workout session**.

Stores: - exercise name - target sets - target repetitions - rest
interval - optional notes

------------------------------------------------------------------------

### SetEntry

Represents a **performed set during an exercise**.

Stores: - set number - weight used - repetitions - timestamp

------------------------------------------------------------------------

# 💾 Data Persistence

GymTracker uses **SwiftData** for local persistence.

Data stored includes:

-   workout sessions
-   exercise sessions
-   set entries

Relationships are modeled using SwiftData relationships to ensure:

-   data consistency
-   cascading deletes
-   clean data structure

------------------------------------------------------------------------

# ⚙️ Tech Stack

-   **Swift**
-   **SwiftUI**
-   **SwiftData**
-   Native iOS development
-   MVVM-inspired architecture

No third-party libraries were used to keep the project **lightweight and
maintainable**.

------------------------------------------------------------------------

# 🚀 Roadmap

### Version 1.1

-   Progress charts
-   Personal record tracking

### Version 1.2

-   iCloud sync
-   Backup & restore

### Version 1.3

-   Apple Watch support

### Future Ideas

-   Workout templates marketplace
-   AI-based training suggestions
-   Volume analytics
-   Muscle group tracking

------------------------------------------------------------------------

# 🧪 Running the Project

Clone the repository:

git clone https://github.com/Matheuscs787/gymtracker.git

Open the project in **Xcode**:

GymTrackerApp.xcodeproj

Build and run using:

-   iOS Simulator
-   Physical iPhone device

------------------------------------------------------------------------

# 📋 Requirements

-   **iOS 17+**
-   **Xcode 15+**
-   macOS Sonoma+

------------------------------------------------------------------------

# 🤝 Contributing

Contributions are welcome!

If you'd like to improve the project:

1.  Fork the repository
2.  Create a new branch
3.  Submit a pull request

------------------------------------------------------------------------

# 👨‍💻 Author

**Matheus Souza**

Backend developer specializing in **Java and distributed systems**,
currently exploring **mobile development with Swift and SwiftUI**.

GitHub: https://github.com/Matheuscs787

LinkedIn: https://linkedin.com/in/math787

------------------------------------------------------------------------

# 📄 License

MIT License

MIT License

Copyright (c) 2026 Matheus Souza

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files to deal in the
Software without restriction.

------------------------------------------------------------------------

# 💡 Motivation

GymTracker started as a **personal solution** to a common problem:
remembering the weights used in previous workouts.

The project evolved into a workout tracking app focused on **speed,
simplicity, and efficiency during training sessions**.

------------------------------------------------------------------------

# 📌 Status

🚧 **In Development**

New features and improvements are continuously being added.
