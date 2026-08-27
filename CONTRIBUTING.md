# Waterfly III Development Guide

## 1. What you need

Waterfly III is a Flutter application for Firefly III. The repository currently uses:

| Component           | Version              |
| ------------------- | -------------------- |
| Flutter             | **3.47.1**           |
| Dart                | Bundled with Flutter |
| Java                | **17**               |
| Android compile SDK | **37**               |
| Android min SDK     | **34**               |
| Gradle              | **9.3.1**            |

The Flutter version is explicitly pinned in:

```text
fastlane/metadata/android/flutter-version.txt
```

It currently contains `3.47.1`.

The CI also reads this file and installs exactly that Flutter version.

**Do not install a separate Dart SDK.** Dart comes with Flutter.

---

# 2. Install Git

Check whether Git is installed:

```bash
git --version
```

If not, install it:

[Git downloads](https://git-scm.com/downloads?utm_source=chatgpt.com)

---

# 3. Install Flutter

Install **Flutter 3.47.1 stable**.

[Flutter SDK archive](https://docs.flutter.dev/install/archive?utm_source=chatgpt.com)

Example location:

### macOS / Linux

```text
~/development/flutter
```

### Windows

```text
C:\src\flutter
```

Add Flutter's `bin` directory to `PATH`.

For macOS/Linux:

```bash
export PATH="$HOME/development/flutter/bin:$PATH"
```

Then verify:

```bash
flutter --version
dart --version
```

You should see Flutter 3.47.1.

Then:

```bash
flutter doctor
```

---

# 4. Install Android Studio

Install:

[Android Studio](https://developer.android.com/studio?utm_source=chatgpt.com)

Install the Android SDK.

The repository currently specifies:

```kotlin
compileSdk = 37
minSdk = 34
```

and Java 17.

In Android Studio:

```text
Settings / Preferences
→ Languages & Frameworks
→ Android SDK
```

Install:

- Android SDK Platform 37
- Android SDK Build-Tools
- Android SDK Command-line Tools
- Android SDK Platform-Tools

You also need either:

- a physical Android phone with USB debugging enabled
- an Android emulator

Check:

```bash
flutter devices
```

---

# 5. Java

The project uses Java 17.

Verify:

```bash
java -version
```

The CI uses Java 17 as well.

If Flutter is using the wrong JDK:

```bash
flutter doctor -v
```

You can explicitly configure one:

```bash
flutter config --jdk-dir="/path/to/jdk-17"
```

---

# 6. Clone the repository

```bash
git clone https://github.com/dreautall/waterfly-iii.git
cd waterfly-iii
```

Switch to `develop`:

```bash
git checkout develop
git pull
```

Verify:

```bash
git branch --show-current
```

Expected:

```text
develop
```

For your actual work, create a branch:

```bash
git checkout -b my-feature
```

---

# 7. Install project dependencies

From the repository root:

```bash
flutter pub get
```

The current `pubspec.yaml` requires Dart SDK `>=3.10.0 <4.0.0` and includes Flutter dependencies plus the code-generation toolchain.

### Important

The repository commits `pubspec.lock`.

Normally use:

```bash
flutter pub get
```

Do **not** casually run:

```bash
flutter pub upgrade
```

That changes dependency resolution and can produce unrelated changes.

---

# 8. Generate API code

Waterfly III uses `build_runner` and `swagger_dart_code_generator`.

The source API definition is under:

```text
swagger_input/
```

The generated API code goes to:

```text
lib/generated/swagger_fireflyiii_api/
```

This is configured in `build.yaml`.

Run:

```bash
dart run build_runner build
```

If you get conflicting generated files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### When do I need this?

Run it when changing:

- Swagger/API definitions
- generated API models
- code using `json_serializable`
- other generated Dart code

For a normal UI-only change, you generally don't need to run it every time.

---

# 9. Generate localization

Localization configuration:

```text
l10n.yaml
```

Source translations:

```text
lib/l10n/
```

English template:

```text
lib/l10n/app_en.arb
```

Generated localization code:

```text
lib/generated/l10n/
```

The repository explicitly configures this output directory.

Generate:

```bash
mkdir -p build
flutter gen-l10n
```

If you modify `.arb` files, run this again.

---

# 10. Run the app

Check available devices:

```bash
flutter devices
```

Then:

```bash
flutter run
```

Or specify one:

```bash
flutter run -d <device-id>
```

Example:

```bash
flutter run -d emulator-5554
```

Normal development loop:

```text
edit code
   ↓
save
   ↓
hot reload
   ↓
test
```

While `flutter run` is active:

```text
r   hot reload
R   hot restart
q   quit
```

---

# 11. Debug builds and signing

For normal development:

```bash
flutter run
```

uses the debug Android configuration.

**You do not need a Waterfly III production signing key.**

The repository gives debug builds a separate application ID suffix:

```text
com.dreautall.waterflyiii.debug
```

This is configured here:

```text
android/app/build.gradle.kts
```

The release configuration is separate.

---

# 12. Local release signing

This is the bit that matters for your original question.

The project loads:

```text
android/key.properties
```

if it exists.

The release signing config expects:

```properties
keyAlias=
keyPassword=
storeFile=
storePassword=
```

### Generate your own local keystore

You do **not** need the production keystore just to build locally.

Create one:

```bash
mkdir -p ~/.android
```

Then:

```bash
keytool -genkeypair \
  -v \
  -keystore ~/.android/waterfly-local.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias waterfly-local
```

Create:

```text
android/key.properties
```

Example:

```properties
storeFile=/Users/YOUR_USER/.android/waterfly-local.jks
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=waterfly-local
```

Windows:

```properties
storeFile=C:\\Users\\YOUR_USER\\.android\\waterfly-local.jks
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=waterfly-local
```

### Important

This is **not** the production signing key.

It is only for local release builds.

The real CI release process creates `key.properties` from GitHub secrets and uses the production/upload keystore.

Never commit:

```text
android/key.properties
```

or:

```text
*.jks
```

---

# 13. Build a release APK

Once your local signing configuration exists:

```bash
flutter build apk --release
```

Or:

```bash
flutter build appbundle --release
```

The project's release build enables:

- minification
- resource shrinking
- ProGuard/R8

and uses the `release` signing config.

---

# 14. CI release build is different

Do not try to reproduce the production release process manually unless you actually need to.

CI:

1. obtains the production keystore from a secret
2. creates `android/key.properties`
3. generates localization
4. builds obfuscated APKs
5. builds the AAB
6. uploads artifacts
7. deploys to the appropriate Google Play track

The production build also uses:

```bash
--obfuscate
--split-debug-info=...
--split-per-abi
```

for APKs.

---

# 15. Formatting

Format Dart code:

```bash
dart format .
```

Check formatting without modifying anything:

```bash
dart format --set-exit-if-changed .
```

The latter is what CI uses.

---

# 16. Static analysis

Run:

```bash
dart analyze .
```

This is also exactly what CI runs.

Fix analyzer errors before submitting a PR.

---

# 17. Tests

Run all tests:

```bash
flutter test
```

This is part of CI.

Run an individual test:

```bash
flutter test test/path/to/test.dart
```

---

# 18. Recommended first successful setup

After installing Flutter, Android Studio and Java:

```bash
git clone https://github.com/dreautall/waterfly-iii.git
cd waterfly-iii

git checkout develop
git pull

flutter --version
flutter doctor

flutter pub get

dart run build_runner build --delete-conflicting-outputs

mkdir -p build
flutter gen-l10n

flutter devices

flutter run
```

If the app starts, your basic development environment is working.

---

# 19. Before opening a PR

Run:

```bash
dart format .
dart analyze .
flutter test
```

If generated code was affected:

```bash
dart run build_runner build --delete-conflicting-outputs
```

If localization was affected:

```bash
mkdir -p build
flutter gen-l10n
```

Then inspect:

```bash
git status
git diff
```

Make sure there are no accidental generated/build artifacts or local secrets.

---

# 20. Useful project map

```text
waterfly-iii/
│
├── android/                         Android / Gradle
│   ├── app/
│   │   └── build.gradle.kts         Android build configuration
│   └── key.properties               LOCAL ONLY, do not commit
│
├── ios/                             iOS project
│
├── lib/                             Main Flutter application
│   ├── generated/                   Generated Dart code
│   └── l10n/                        Localization sources
│
├── test/                            Flutter tests
│
├── assets/                          Application assets
│
├── swagger_input/                   Firefly III API definition
│
├── fastlane/                        Release/store configuration
│   └── metadata/android/
│       └── flutter-version.txt      Flutter version used by CI
│
├── .github/
│   ├── workflows/
│   │   ├── commit.yml               Analyze + test
│   │   └── release.yml              Build + release
│   └── actions/
│       └── setup_env/               CI environment setup
│
├── pubspec.yaml                     Dependencies
├── pubspec.lock                     Locked dependency versions
├── build.yaml                       build_runner configuration
├── l10n.yaml                        Localization configuration
└── analysis_options.yaml            Dart analyzer configuration
```

---

# 21. The three commands to remember

For most Waterfly III development:

```bash
flutter run
```

```bash
dart analyze .
```

```bash
flutter test
```

And when you change generated/API code:

```bash
dart run build_runner build --delete-conflicting-outputs
```
