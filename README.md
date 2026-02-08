# Coralis Flutter

This project implements user authentication features including Register, Login, and Forgot Password, integrated with a backend API.

## Features

- **Register**: Create a new account with name, email, and password.
- **Login**: Authenticate with email and password to access the home screen.
- **Forgot Password**: Request a password reset token via email.
- **Reset Password**: Set a new password using the received token.

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.22+)
- An Android Emulator or Physical Device

## Installation

1.  **Clone the repository**

2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Configure Environment**:
    
    Copy the example environment file to create your local configuration:
    ```bash
    cp .env.example .env
    ```

    Open `.env` and adjust `BASE_API_URL` if needed.

## Configuration

**For Android Emulator:**
If your backend is running locally on your machine at port `3000`:
```env
BASE_API_URL=http://10.0.2.2:3000/api
```

**For Physical Device:**
Use your machine's local IP address (e.g., `192.168.1.x`):
```env
BASE_API_URL=http://YOUR_LOCAL_IP:3000/api
```

## Running the Application

1.  **Start your Backend Server**: Ensure your backend API is running.
2.  **Start the Android Emulator**.
3.  **Run the Flutter App**:

    ```bash
    flutter run
    ```

## Project Structure

-   `lib/data`: Data Sources, Models, and Repositories.
-   `lib/presentation`: Screens, Components, Router, and Themes.
-   `lib/common`: Utility classes and configuration.
-   `lib/injection.dart`: Dependency Injection setup.
