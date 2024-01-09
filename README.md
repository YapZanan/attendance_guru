# Flutter Project - Attendance Guru

This is a detailed installation guide for setting up Flutter, Android Studio, and cloning the Attendance Guru project. It is specifically designed for beginners who have no prior experience with these tools.

## Installation

Please follow the step-by-step instructions below to install Flutter, set up Android Studio, and clone the Attendance Guru project.

### 1. Install Android Studio

Android Studio is the official integrated development environment (IDE) for Android app development.

- Download Android Studio from the official website: [Download Android Studio](https://developer.android.com/studio).
- Choose the appropriate download link for your operating system (Windows, macOS, or Linux).
- Follow the installation guide provided by Google based on your operating system to complete the installation process.

### 2. Set Up Flutter

Flutter is an open-source UI software development kit created by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.

- Download Flutter SDK from the official website: [Download Flutter SDK](https://flutter.dev/docs/get-started/install).
- Extract the downloaded Flutter SDK archive to a location of your choice on your computer (e.g., `C:\flutter` on Windows or `/Users/<your-username>/flutter` on macOS/Linux).
- To use Flutter from the command line, append the Flutter SDK's `bin` directory to your **system PATH** variable:
    - **Windows**:
        - Open the **Start** menu and search for "Environment Variables".
        - Click on **Edit the system environment variables**.
        - Click on the **Environment Variables...** button.
        - In the **System variables** section, select the **Path** variable and click **Edit**.
        - Click **New** and add the path to the `bin` directory of your Flutter SDK installation (e.g., `C:\flutter\bin`).
        - Click **OK** to save the changes.
    - **macOS/Linux**:
        - Open a terminal window.
        - Run the following command to open your shell configuration file (.bash_profile, .zshrc, etc.):
            ```bash
            $ open ~/.bash_profile
            ```
          or
            ```bash
            $ open ~/.zshrc
            ```
        - Add the following line at the end of the file, replacing `<path-to-flutter-sdk>` with the actual path to your Flutter SDK installation:
            ```bash
            export PATH="$PATH:<path-to-flutter-sdk>/bin"
            ```
        - Run the following command to apply the changes:
            ```bash
            $ source ~/.bash_profile
            ```
          or
            ```bash
            $ source ~/.zshrc
            ```

### 3. Install Android Studio Plugins

Plugins in Android Studio provide additional features and functionality. We need to install Flutter and Dart plugins.

- Open Android Studio.
- Go to **Preferences** (on macOS) or **Settings** (on Windows/Linux) from the main toolbar.
- In the left sidebar, select **Plugins**.
- In the search bar, type "Flutter".
- Click on the **Marketplace** tab to find the Flutter plugin.
- Click **Install** to download and install the Flutter plugin.
- Similarly, search for "Dart" and install the Dart plugin.

### 4. Verify Flutter Installation

Before proceeding, let's verify that Flutter is installed correctly.

- Open your terminal or command prompt.
- Run the following command to check if Flutter is correctly installed:
    ```bash
    $ flutter doctor
    ```
- The output should display "No issues found!" if Flutter is correctly installed and no additional setup is required.

### 5. Clone Attendance Guru Project

Now, let's clone the Attendance Guru project from GitHub.

- Open your terminal or command prompt.
- Change to the directory where you want to clone the project to (e.g., your projects folder):
    ```bash
    $ cd ~/projects
    ```
- Run the following command to clone the Attendance Guru repository:
    ```bash
    $ git clone https://github.com/YapZanan/attendance_guru.git
    ```
- This will download the project files and create a new folder named `attendance_guru` in your current directory.

## Running the Project

Now that you have everything set up, let's run the Attendance Guru project.

### 1. Open the Project in Android Studio

- Open Android Studio.
- Select **Open an existing project** from the main window.
- Navigate to the `attendance_guru` directory you cloned earlier and click **OK**.

### 2. Configure Android Emulator

For running the app, you need to configure an Android emulator.

- Open **AVD Manager** by clicking on the AVD Manager icon in the toolbar (looks like a mobile phone screen).
- Click **Create Virtual Device** to create a new emulator.
- Choose a device from the list (e.g., Pixel 2 or Pixel 3) and click **Next**.
- Select a system image of your choice (preferably the latest stable version) and click **Next**.
- Provide a name for your emulator (e.g., "Pixel_2_API_29") and click **Finish**.

### 3. Run the Project

You are now ready to run the Attendance Guru project.

- In Android Studio, from the toolbar, choose the emulator you just created from the **Connected Devices** dropdown list.
- Click on the **Run** button (green play button) or press **Shift+F10** to start the application.
- The app will be built and launched in the emulator. Please wait for it to load. It might take a few minutes on the first run.

---

Congratulations! You have successfully installed Flutter, set up Android Studio, and cloned the Attendance Guru project. If you encounter any issues or have further questions, feel free to ask for assistance.