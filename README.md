# Cupertino Catalog

A hands-on catalog of **Flutter's official Cupertino (iOS-style) widgets**, built
with nothing but `package:flutter/cupertino.dart`.

Every screen in the app is a live demo: buttons, switches, sliders, segmented
controls, text fields, search fields, tab bars (both embedded and a full
`CupertinoTabScaffold`), wheel/date/timer pickers, activity indicators, alerts,
action sheets, context menus, inset-grouped lists, form sections, system colors,
the Cupertino type ramp and the icon font. A moon/sun button in the navigation
bar flips the whole app between light and dark so the dynamic system colors can
be compared.

## Build

The APK is built by GitHub Actions (`.github/workflows/android.yml`). The
workflow scaffolds the Android platform folder with `flutter create`, builds a
release APK with the Flutter stable channel, uploads it as a workflow artifact
and publishes it as a GitHub Release.

Local build:

```bash
flutter create --platforms=android --org dev.zevenz --project-name cupertino_catalog _scaffold
cp -r _scaffold/android .
flutter pub get
flutter build apk --release
```

The APK lands in `build/app/outputs/flutter-apk/app-release.apk`.
