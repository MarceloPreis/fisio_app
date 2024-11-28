#!/bin/sh

cd packages

cd google_mlkit_commons
flutter pub get

cd ../google_mlkit_pose_detection
flutter pub get

cd ../google_ml_kit
flutter pub get

cd ../app
flutter pub get
