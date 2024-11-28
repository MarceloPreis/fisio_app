import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class ExerciseRule  {
  final String errorMessage;
  final Function(Map<PoseLandmarkType, PoseLandmark> landmarks) test;
  // late final Map<PoseLandmarkType, PoseLandmark> landmarks;

  ExerciseRule ({
    required this.errorMessage,
    // required landmarks,
    required this.test,
  });
}
