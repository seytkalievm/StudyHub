# Study Hub

<img src="./assets/readme/logo.png" alt="logo" width="100"/>

![Flutter check](https://github.com/InnoStudyHub/front-end/actions/workflows/flutter_check.yml/badge.svg)

## About the project

### Problem

As Innopolis University students we noticed the lack of time problem while preparing to the exams. Students try to find the materials used by previous years for exam preparation in telegram chats to use their time more efficient.

### Solution

So, we introduce an application that will store the materials for exam preparation.

It is a crowdsourcing educational application aimed towards Innopolis University students. The app is directed to ease the process of the material assimilation and exam preparation.

The idea is to store the courses material in the form of cards, where one side is a question, another - answer.

## Prerequisites

For this project you need to have Flutter in your machine. Installation instruction for different OSes can be found [here](https://docs.flutter.dev/get-started/install).

## How to use

Clone the repo into your folder:

```bash
git clone https://github.com/InnoStudyHub/front-end.git
cd ./front-end
flutter pub get
```

Build and run the project on your host:

```bash
flutter run
```

Build web version:

```bash
flutter build web --web-renderer html
cd web
python -m http.server 8000
```

Build Android version (apk):

```bash
flutter build apk
```

Build iOS version (ipa) - available only on macOS:

```bash
flutter build ios
```

## How to contribute

Fork this repository, make changes, send us a pull request. We will review your changes and apply them to the master branch if they don't violate the quality standards.

We are planning to add:

- raiting system in a form of likes and dislikes
- privacy via deck access levels and study groups
- discussions in comments under the cards
- raiting of users to increase the crowdsourcing motivation
