# Promptuario

A responsive Flutter application with adaptive layouts for web and iPad.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- Responsive layouts for web and iPad
- Adaptive grid and list views
- NavigationRail for tablet and desktop
- Material 3 design system

## Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart SDK
- Web browser (Chrome recommended)
- Xcode (for iOS/iPad development)

## Setup Instructions

1. Clone the repository using GitHub CLI:
   ```bash
   gh repo clone davidsanchezg/promptuario
   cd promptuario
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   - For web:
     ```bash
     flutter run -d chrome
     ```
   - For iPad:
     ```bash
     flutter run -d ios
     ```

4. Create a new branch for your changes:
   ```bash
   gh branch create feature/your-feature-name
   ```

5. Push your changes:
   ```bash
   git add .
   git commit -m "Your commit message"
   git push origin feature/your-feature-name
   ```

6. Create a pull request:
   ```bash
   gh pr create --title "Your PR title" --body "Your PR description"
   ```

## Development

The project uses:
- `responsive_builder` for adaptive layouts
- Material 3 design system
- Dart 3.8.1

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
