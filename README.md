# 🍽️ CookBook App

A simple yet feature-rich iOS app to explore, add, and manage delicious recipes. Built using **SwiftUI**, **MVVM architecture**, and **Core Data**, with Firebase authentication for secure login/signup.

---

## 📱 Features

- ✅ **User Authentication**
  - Login / Signup with Firebase
- 📷 **Add Recipes**
  - Title, instructions, and image picker
  - Save recipes to Core Data
- 🔍 **Search Recipes**
  - Real-time search bar for both Core Data and mock data
  - "No results found" fallback UI
- 🖼️ **Recipe Assets**
  - Supports local images stored in `Assets.xcassets`
- 🎨 **Splash Screen**
  - Custom animated splash screen on launch
- 🧱 **MVVM Architecture**
  - Clean separation of views, models, and logic
- 💾 **Offline Storage**
  - Recipes saved using Core Data for persistent storage

---

## 🧰 Tech Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM
- **Persistence**: Core Data
- **Authentication**: Firebase Auth
- **Other Tools**: Xcode, Git, GitHub

---

## 🖼️ Screenshots

### 🧁 Splash Screen
<img width="300" height="1302" alt="Splash Screen" src="https://github.com/user-attachments/assets/2caa0c0e-0231-4ac2-9d2a-276ac2183e46" />

### 📝 SignUp Page
<img width="300" height="1318" alt="SignUpPage" src="https://github.com/user-attachments/assets/a1ba2ab6-df61-45da-9488-123f531fe29a" />

### 🔐 Login Page
<img width="300" height="1306" alt="LoginPage" src="https://github.com/user-attachments/assets/d0b0aef3-9bdc-4237-80ea-29b7b113a089" />

### 🏠 Home Page
<img width="300" height="1324" alt="HomePage" src="https://github.com/user-attachments/assets/b84031fa-8edd-4070-b6d7-fbd7aa4035ca" />

### 🍽️ Recipe Detail Page
<img width="300" height="1340" alt="ReceipeDetailPage" src="https://github.com/user-attachments/assets/d11ee7cf-8ab7-4748-b078-d4deeb452b23" />

### ➕ Add Recipe Page
<img width="300" height="1310" alt="AddReceipePage" src="https://github.com/user-attachments/assets/9d66519c-650e-4dd7-a82b-da422345a654" />

### 🚪 Logout
<img width="300" height="1298" alt="Logout" src="https://github.com/user-attachments/assets/41205ec7-c103-49b9-b1cc-ece20fcc8b5f" />






---

## 📂 Project Structure
CookBook/
├── Assets/                  # App image assets (recipes, logo, etc.)
├── Colors/                  # Custom color definitions
├── Components/              # Reusable UI components (buttons, text fields, etc.)
├── CookBookApp.swift        # App entry point (AppDelegate & @main struct)
├── GoogleService-Info.plist # Firebase config file
├── Info.plist               # App configuration
├── Managers/                # API and Core Data managers
├── Models/                  # App and Core Data models
├── Preview Content/         # SwiftUI preview mock data
├── Utilities/               # Utility files 
├── ViewModels/              # All MVVM ViewModels
├── Views/                   # All SwiftUI Screens
