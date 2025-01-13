# Budget Tracker App

A comprehensive budget tracker app built with Flutter, featuring functionalities to manage spending and categories efficiently using the SQLite database (`sqflite` package).

## Features

### Spending Management
- **View All Spending Details**: Display a detailed list of all spending records.
- **Add Spending**: Input new spending details, including the amount, category, and date.
- **Edit Spending**: Modify existing spending records for corrections or updates.
- **Delete Spending**: Remove unwanted or outdated spending records.

### Category Management
- **View All Categories**: Display a categorized list of all spending categories.
- **Add Categories**: Create new categories to organize spending efficiently.
- **Edit Categories**: Update category details like name or icon.
- **Delete Categories**: Remove unused or redundant categories.

## Technologies Used
- **Flutter**: For the app’s user interface and navigation.
- **SQLite (sqflite)**: To store and manage data locally on the device.
- **State Management**: Implemented using GetX for seamless state updates.

## Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/budget-tracker-app.git
2. **Navigate to the Project Directory**
   ```bash
   cd budget-tracker-app
3. **Install Dependencies**
   ```bash
   flutter pub get
4.  **Run the Application**
    ```bash
    flutter run

## Database Schema

### Tables

1. **Spending**:
   - `id` (Integer, Primary Key)
   - `amount` (Double)
   - `category_id` (Integer, Foreign Key)
   - `date` (String)
   - `description` (String)

2. **Categories**:
   - `id` (Integer, Primary Key)
   - `name` (String)
   - `icon` (String)

---

## App Screens

### Home Screen:
- Displays an overview of total spending.
- Provides quick access to adding new spending.

### Spending Screen:
- Lists all spending details.
- Options to edit or delete a record.

### Category Screen:
- Displays all categories with options to add, edit, or delete.

### Add/Edit Spending Screen:
- Form to input spending details.

### Add/Edit Category Screen:
- Form to input category details.

---

## Screenshots and Video Demo

### Screenshots

Add your screenshots here to showcase the app interface.

1. **Home Screen**:
   ![Home Screen](screenshots/home_screen.png)

2. **Spending Details**:
   ![Spending Screen](screenshots/spending_screen.png)

3. **Category Management**:
   ![Category Screen](screenshots/category_screen.png)

---

### Video Demo
Embed or link your video demo here to give an overview of the app functionality.

[Watch Demo Video](https://example.com/demo)
