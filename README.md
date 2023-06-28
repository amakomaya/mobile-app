# aamako_maya

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### To generate and update locale file and translations
Export each sheet to tsv and put them inside gen/tsv_files
then run:
dart run gen/generate.dart
flutter gen-l10n
flutter pub get
flutter pub run easy_localization:generate -S assets/l10n -f keys -O lib/l10n -o locale_keys.g.dart