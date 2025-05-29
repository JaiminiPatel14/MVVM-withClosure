# MVVM with Closure

A simple iOS app demonstrating MVVM architecture using closures for communication between layers.

## Features
- Login authentication
- Product listing
- Error handling
- Network layer with async/await
- Coordinator pattern for navigation

## Architecture
- **MVVM**: ViewModels handle business logic and communicate with Views using closures
- **Network Layer**: Async/await based network service with error handling
- **Coordinators**: Handle navigation flow
- **Closures**: Used for communication between layers instead of delegates

## Project Structure
```
MVVM-withClosure/
├── Core/
│   ├── Network/
│   └── Navigation/
├── Screens/
│   ├── Auth/
│   └── Products/
├── Common/
│   ├── Protocols/
│   └── Views/
└── Utility/
```

## Installation
1. Clone the repository
2. Open `MVVM-withClosure.xcodeproj`
3. Build and run 
