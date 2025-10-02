# Flutter Huevo

🥚 welcome to Flutter Huevo.

Watch/star this repo to be notified when updates are pushed.

## Table of Contents

<!-- TOC -->
* [Flutter Huevo](#your-project-id-pro)
  * [Table of Contents](#table-of-contents)
  * [What is Flutter Huevo?](#what-is-your-project-id)
  * [About the Author](#about-the-author)
  * [Get Started](#get-started)
    * [Option 1 - Template](#option-1---template)
    * [Option 2 - Fork](#option-2---fork)
    * [Option 3 - Cherry-Pick](#option-3---cherry-pick)
  * [Requirements](#requirements)
* [Features](#features)
* [Docs](#docs)
  * [Firebase](#firebase)
  * [Google Sign In](#google-sign-in)
  * [Apple Sign In](#apple-sign-in)
  * [Notifications](#notifications)
  * [RevenueCat](#revenuecat)
  * [Mixpanel](#mixpanel)
  * [Code Architecture](#code-architecture)
  * [Styling](#styling)
  * [Google Fonts](#google-fonts)
  * [Localization](#localization)
  * [Android Release Signing](#android-release-signing)
  * [Useful GitHub Pull Request Settings](#useful-github-pull-request-settings)
* [FAQ](#faq)
  * [Why bloc and not X?](#why-bloc-and-not-x)
  * [Where to learn Flutter basics?](#where-to-learn-flutter-basics)
  * [What if I don't need a specific feature?](#what-if-i-dont-need-a-specific-feature)
  * [Help: Login stuck on loading overlay](#help-login-stuck-on-loading-overlay)
* [Resources](#resources)
* [Support](#support)
<!-- TOC -->

## What is Flutter Huevo?

Flutter Huevo is a starter template for Flutter & Firebase apps.

It's designed to be scalable and easy to maintain. And should save you months of development time.

## Get Started

There are 3 ways to get started: Template, Fork, and Cherry-Pick.

### Option 1 - Template

_Best if you want to start a new project from scratch with all the SFA features included.
And you don't care about keeping your project up to date with the SFA repo._

To get started with Option 1: Template, click the green "Use this template" button above.

### Option 2 - Fork

_Best if you want to start a new project from scratch with all the SFA features included.
And you want to keep your repo up to date with the SFA repo._

To get started with Option 2: Fork, fork the repo and follow the instructions below.

### Option 3 - Cherry-Pick

_Best if you have an existing project and want to manually pick the SFA features you want.
Or if you want better control over what features you want._

To get started with Option 3: Cherry-Pick simply use this GitHub repo as a guide.

And cherry-pick (copy & paste) the features and files you want to use into your own project.

## Requirements

Always keep up to date:

- Flutter
- Cocoapods
- Firebase CLI

# Features

| Feature                                                              | Pro |
|----------------------------------------------------------------------|-----|
| Platforms: Android, iOS, web                                         | ✅   |
| Scalable Architecture using [flutter_bloc](https://bloclibrary.dev/) | ✅   |
| Navigation using [go_router](https://pub.dev/packages/go_router)     | ✅   |
| Scalable App Styling                                                 | ✅   |
| GitHub Actions - code and formatting check                           | ✅   |
| Responsive Design                                                    | ✅   |
| Profile Page                                                         | ✅   |
| Settings Page: sign out, app version...                              | ✅   |
| Legal: Terms, Policy, Data Deletion                                  | ✅   |
| Google Fonts                                                         | ✅   |
| Sign in and Sign Up Pages                                            | ✅   |
| Input Validators                                                     | ✅   |
| Cached network image                                                 | ✅   |
| Email Support                                                        | ✅   |
| Lifetime Updates                                                     | ✅   |
| Firebase Project Integration                                         | ✅️  |
| Firebase Cloud Functions                                             | ✅️  |
| Firebase Authentication                                              | ✅ ️ |
| Firebase Remote Config                                               | ✅ ️ |
| Firebase Crashlytics                                                 | ✅ ️ |
| Firebase Firestore                                                   | ✅ ️ |
| Firebase Analytics                                                   | ✅   |
| Firebase Hosting                                                     | ✅   |
| Firebase Storage                                                     | ✅️  |
| Google Sign In                                                       | ✅ ️ |
| Apple Sign In                                                        | ✅ ️ |
| Common Cubits                                                        | ✅ ️ |
| In App Purchases (RevenueCat)                                        | ✅ ️ |
| App Store Review Request                                             | ✅ ️ |
| Local Notifications                                                  | ✅ ️ |
| Remote Notifications (Firebase)                                      | ✅ ️ |
| HTTP Requests (dio)                                                  | ✅ ️ |
| Local Storage                                                        | ✅ ️ |
| Permissions                                                          | ✅ ️ |
| Environments                                                         | ✅ ️ |
| Localization                                                         | ✅️  |
| Dark Mode                                                            | ✅ ️ |
| Connectivity check                                                   | ✅ ️ |
| Hive - local database                                                | ✅ ️ |
| MixPanel - analytics                                                 | ✅ ️ |
| Android - Release Signing                                            | ✅ ️ |
| Onboarding                                                           | ✅ ️ |
| Forgot Password                                                      | ✅ ️ |
| Send Feedback Message                                                | ✅ ️ |
| Delete User Account                                                  | ✅ ️ |
| Get User Timezone                                                    | ✅ ️ |
| 🎉 BONUS: Scalable Firebase Backend Template                         | ✅ ️ |

# Docs

## Firebase

Firebase Console project set up:

1. Create a new Firebase project (if you don't already have one)
2. Enable Firestore
3. Enable Auth
4. Enable Email/Password sign-in method
5. Switch to Blaze plan (pay as you go)
6. Enable Cloud Functions
7. Enable Storage (if needed)
8. Enable Hosting (if needed)
9. Enable Remote Config (if needed)

If you're using Flutter web with Firebase Storage, you'll need to enable CORS:

If you want to deploy your Flutter web app:

1. Run `firebase init`
2. Select `Hosting: Configure files for Firebase Hosting and (optionally) set up GitHub Action deploys`
3. Select your Firebase project
4. Enter `build/web` as the public directory
5. Enter `Y` for single-page app
6. Enter `N` for automatic builds and deploys with GitHub Actions

After that's done, you can deploy your Flutter web app with:

1. `flutter build web`, then
2. `firebase deploy`.

To set up Firebase in the `/app` project:

1. Run `cd app`
2. Run `flutterfire configure` in the terminal
3. Select your Firebase project
4. Select platforms you want to support (Android, iOS, web)
5. If asked to update files, select `y` (yes)
6. (if using Cloud Functions) update the region in `app/lib/core/firebase/cloud_functions_provider.dart:21`

To set up Firebase in the `/firebase` project:

1. (if using Cloud Functions) update the region in `firebase/functions/src/index.ts:10`
2. Run `cd firebase`
3. Run `firebase login` in the terminal
4. Run `firebase projects:list` to see your Firebase projects
5. Find your project ID (i.e. `your-project-id`)
6. Run `firebase use <project-id>` (i.e. `firebase use your-project-id` to set your Firebase project
7. Run `cd functions`
8. Run `npm install` 
9. Run `cd ..`
10. Run `firebase deploy` to deploy Firestore rules and Cloud Functions to your Firebase project

## Google Sign In

Here's how to set up Google Sign In: 

## Apple Sign In

Here's how to set up Apple Sign In: 

## Notifications

Notifications on iOS require additional setup:

## RevenueCat

To integrate RevenueCat:

1. Set up RevenueCat: https://www.revenuecat.com/docs/getting-started
2. Update `_androidApiKey` and `_iosApiKey` in `app/feature/payment/provider/revenue_cat_provider.dart`
3. Update `Paywall` in `app/feature/payment/model/paywall.dart` to fit your needs
4. Update `PaywallPage` in `app/feature/payment/ui/page/paywall_page.dart` to fit your needs
5. Update `_ProviderDI` to use `RevenueCatProvider` instead of `MockPaywallProvider`

## Mixpanel

To integrate Mixpanel:

1. Set up Mixpanel: https://mixpanel.com
2. Update `_mixpanelToken` in `app/lib/feature/analytics/provider/mixpanel_analytics_provider.dart`

## Code Architecture

The code architecture is based on
[flutter_bloc architecture proposal](https://bloclibrary.dev/#/architecture).

There are 4 layers:

1. UI (Flutter Widgets)
2. BLoC (stateful business logic)
3. Repository (high-level API)
4. Provider (low-level implementation)

And there's only 1 communication rule that we must follow:

_**The layer can only call the one layer below it.**_

That means that:

- UI can only call BLoC
- BLoC can only call Repository
- Repository can only call Provider
- Provider can only call external services (Firebase, HTTP, etc.)

And we avoid same-layer communication (as it creates interdependencies):

- `UserRepository` calling `AuthRepository` is _**not**_ allowed.
- `UserCubit` calling `UserRepository` and `AuthRepository` is allowed.

When creating Providers, Repositories, and Cubits we follow this rule:

- Providers are created top-level (so that they can be used in multiple Repositories)
- Repositories are created top-level (so that they can be used in multiple Cubits)
- Cubits are created in the router builder callbacks (so that they're accessible only where needed)
- Cubits that are used in multiple screens are created top-level

## Styling

Styling is based on [Google's Material Design](https://material.io/design).

App-wide styling is defined in `core/app/style.dart` and is easy to update.

Here's a quick tip on custom Widget params. There are 2 Widget param types:

- data (user, title, ...)
- style (colors, paddings, ...)

Our custom Widgets should only hava data params.

And the style should be done app-wide (in `style.dart`).

That way all of our UI is consistent and easy to update.

## Google Fonts

To change the font:

1. Go to [Google Fonts](https://fonts.google.com/) and select a font.
2. Download the font files.
3. Add the font files to `assets/fonts` (remove the old ones).
4. Update `style.dart` with the new font (i.e. `return GoogleFonts.rubikTextTheme(textTheme)`).

## Localization

Localized string files are in `lib/l10n`.

To remove a language, just remove it's `.arb` file.

To add a language, duplicate `app_en.arb` and rename it to `app_xx.arb`
(where `xx` is the language code). Then translate the strings.

## Android Release Signing

1. Create a keystore file (if you don't already have one): 
```
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
-keysize 2048 -validity 10000 -alias upload
```
2. Create `app/android/key.properties` file with the following content:
```
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>
```
3. To build the release bundle, run `flutter build appbundle`

## Useful GitHub Pull Request Settings

I've found that turning on these 2 settings in GitHub repo settings helps a lot:

1. `Always suggest updating pull request branches`
2. `Automatically delete head branches`
