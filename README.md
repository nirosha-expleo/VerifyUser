# VerifyUser

A Flutter web application with mobile screen support, featuring document-style navigation.

## Features

- ✅ **Mobile Responsive Design**: Works seamlessly on mobile devices and browsers
- ✅ **Document-Style Navigation**: Navigate through screens like pages in a document
- ✅ **Modern UI**: Follows the same theme and color scheme as the existing Expleo projects
- ✅ **Web Optimized**: Fully configured for web deployment
- ✅ **Responsive Layout**: Automatically adapts to different screen sizes

## Project Structure

```
VerifyUser/
├── lib/
│   ├── config/
│   │   ├── app_router.dart      # Navigation routing configuration
│   │   └── app_theme.dart        # Theme configuration
│   ├── screens/
│   │   ├── document_viewer_screen.dart  # Main document viewer
│   │   ├── screen1.dart         # Welcome screen
│   │   ├── screen2.dart         # User Information screen
│   │   ├── screen3.dart         # Verification Process screen
│   │   ├── screen4.dart         # Details View screen
│   │   └── screen5.dart         # Summary screen
│   ├── utility/
│   │   ├── app_colors.dart      # Color definitions
│   │   └── responsive_helper.dart  # Responsive design utilities
│   └── main.dart                # Application entry point
├── web/
│   ├── index.html               # Web entry point
│   └── manifest.json            # PWA manifest
└── assets/
    ├── images/                  # Image assets
    ├── icons/                   # Icon assets
    └── fonts/                   # Font assets
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)

### Installation

1. Navigate to the project directory:
   ```bash
   cd /Users/nirosha/Documents/Expleo/VerifyUser
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run -d chrome
   ```

### Building for Web

To build the web application:

```bash
flutter build web
```

The built files will be in the `build/web` directory.

## 🚀 Deployment to GitHub Pages

### Quick Start

1. **Build for GitHub Pages:**
   ```bash
   # Replace 'verifyuser' with your GitHub repository name
   flutter build web --base-href "/verifyuser/" --release
   ```

2. **Deploy using script:**
   ```bash
   chmod +x deploy.sh
   ./deploy.sh verifyuser
   ```

3. **Or use GitHub Actions** (automatic deployment):
   - Push your code to GitHub
   - Enable GitHub Pages in repository settings
   - The `.github/workflows/deploy.yml` will automatically deploy on every push

### Detailed Instructions

See **[DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)** for complete step-by-step instructions.

**Your app will be available at:**
```
https://YOUR_USERNAME.github.io/verifyuser/
```

## Navigation

The application features a document-style navigation system:

- **Desktop/Tablet**: Sidebar navigation with screen list
- **Mobile**: Bottom navigation bar with Previous/Next buttons
- **All Devices**: Navigation buttons on each screen

## Customization

### Adding New Screens

1. Create a new screen file in `lib/screens/`
2. Add the route to `lib/config/app_router.dart`
3. Update the screens list in `lib/screens/document_viewer_screen.dart`

### Modifying Colors

Edit `lib/utility/app_colors.dart` to change the color scheme.

### Modifying Theme

Edit `lib/config/app_theme.dart` to customize the app theme.

## Responsive Design

The application uses `ResponsiveHelper` utility to:
- Detect device type (mobile/tablet/desktop)
- Adjust padding and margins
- Scale font sizes appropriately
- Set maximum content widths

## Browser Support

- Chrome/Edge (recommended)
- Firefox
- Safari
- Mobile browsers (iOS Safari, Chrome Mobile)

## License

This project is part of the Expleo development workspace.

