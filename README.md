# MyMedicine - iOS Medication Reminder App

> This project represents **over a week of dedicated work**, focusing on creating a user-friendly and reliable medication management tool for iOS using modern Apple technologies.

MyMedicine is a SwiftUI-based iOS application designed to help users manage their medications effectively. It allows you to set reminders, track your intake history, and even browse a built-in pharmacy store.

## ✨ Features

- **💊 Medication Management**: Add, edit, and delete medicines with custom names, descriptions, and dosages
- **⏰ Smart Reminders**: Set multiple daily reminder times for each medication
- **📈 Intake History**: Keep track of when you've taken your medicine
- **🛍️ Integrated Pharmacy Store**: Browse and "purchase" common medicines directly within the app
- **👤 User Profile**: Manage personal information and view usage statistics
- **🛒 Shopping Cart**: Add products to cart and simulate purchases

## 🛠️ Technologies & Frameworks Used

### **Core Technologies**
- **Swift 5** - Primary programming language
- **SwiftUI** - Modern declarative UI framework
- **Xcode 14+** - Development environment

### **Apple Frameworks**
- **UserNotifications** - Local notification system for medication reminders
- **Combine** - Reactive programming for data flow management
- **SwiftUI** - Complete UI implementation including:
  - `@State`, `@Binding`, `@StateObject`, `@EnvironmentObject` for state management
  - `List`, `Form`, `NavigationView`, `TabView` for navigation and layout
  - `@AppStorage` for simple data persistence

### **Architecture & Design Patterns**
- **MVVM (Model-View-ViewModel)** - Primary architectural pattern
- **ObservableObject** - For reactive data updates
- **EnvironmentObject** - For dependency injection across views
- **@Published** - For property observation

### **Data Management**
- **UserDefaults** - Local data persistence for medicines, history, and user preferences
- **JSON Encoding/Decoding** - Custom data serialization with `Codable` protocol
- **Custom Data Models** - Structured data with `Identifiable`, `Equatable` protocols

### **UI/UX Features**
- **Modern iOS Design** - Native iOS components and interactions
- **Search Functionality** - Real-time filtering across medicines and products
- **Swipe Actions** - Quick actions (delete, edit, mark as taken)
- **Sheets & Modals** - Contextual presentations for adding/editing data
- **Custom Components** - Reusable SwiftUI views throughout the app

### **Advanced Features**
- **Local Notifications** - Scheduled reminders using `UNUserNotificationCenter`
- **Date & Time Management** - Complex date handling for medication schedules
- **Shopping Cart System** - Complete e-commerce simulation
- **Category Filtering** - Dynamic product categorization
- **Form Validation** - Input validation with disabled states

## 🚀 Getting Started

### Prerequisites
- Xcode 14.0 or later
- iOS 16.0 or later
- A device or simulator running iOS 16+

### Installation
1. Clone the repository:
```bash
git clone https://github.com/MateusTibaes/MyMedicine.git
