# Shorebird Setup and Deployment Instructions

Follow these steps to install and use Shorebird for your Flutter project.

---

### 1. Install Shorebird

```bash
curl --proto '=https' --tlsv1.2 https://raw.githubusercontent.com/shorebirdtech/install/main/install.sh -sSf | bash
```

After installation, **close and reopen your terminal**.

---

### 2. Login to Shorebird

```bash
shorebird login
```

---

### 3. Initialize Shorebird in Your Project

Use this when initializing Shorebird for the first time or when the **build number is changed**.

```bash
shorebird init
```

---

### 4. Release App to App Store or Play Store

Use the following commands to create a release build:

```bash
shorebird release android
```

```bash
shorebird release ios
```

---

### 5. Create a Preview Build for Testing

```bash
shorebird preview
```

If you want to create an **APK file**, use:

```bash
shorebird release android --artifact apk
```

If you want an **IPA file for the development environment**, use:

```bash
shorebird release ios --export-method development
```

---

### 6. Patch an Update for Android

```bash
shorebird patch android
```

---

### 7. Clear Logcat Logs

```bash
adb logcat -c
```

---

### 8. View Flutter Logs Only

```bash
adb logcat -s flutter
```

---

> ✅ Use these steps to manage releases, previews, patches, and debugging using Shorebird with your
> Flutter project.