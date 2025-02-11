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

1. **Splash Screen**:
   
<img src="https://github.com/user-attachments/assets/04f80a29-2941-4295-88d8-e2c4323a727b" width="300px">|

2. **Spending Management**:

<img src="https://github.com/user-attachments/assets/cf048c4f-2741-4670-93ae-c2639fd8c708" width="300px">|
<img src="https://github.com/user-attachments/assets/862f6b64-9d4c-4890-b7ab-87a392449872" width="300px">|
<img src="https://github.com/user-attachments/assets/a2491843-a3ee-44c2-916c-c35f498eb035" width="300px">|
<img src="https://github.com/user-attachments/assets/9d9551e2-9e9c-4736-9a97-241cb3e0e129" width="300px">|
     
3. **Spending Details**:

<img src="https://github.com/user-attachments/assets/e4814bbe-04ba-4427-8668-8ef4bfeb0372" width="300px">|

4. **Category Management**:

<img src="https://github.com/user-attachments/assets/e8fde2fb-22b4-45a8-ae99-c06a920bd27a" width="300px">
<img src="https://github.com/user-attachments/assets/318a8d3f-6d61-4ab8-89e3-a27a919421e5" width="300px">
<img src="https://github.com/user-attachments/assets/e1aa095c-4a17-449b-859c-e9cd75c30df4" width="300px">
<img src="https://github.com/user-attachments/assets/d0f590a9-8e04-4f1e-be94-0e54d2bfbe90" width="300px">
<img src="https://github.com/user-attachments/assets/84937050-ed03-45b3-89cd-7ccafbed0ab5" width="300px">

5. **Category Details**:

<img src="https://github.com/user-attachments/assets/c694da09-d194-42a9-b622-757414636d0a" width="300px">

---

### Video Demo

https://github.com/user-attachments/assets/6f42a0e2-d315-4299-9472-f4a8a10810dc
