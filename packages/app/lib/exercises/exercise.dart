import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

abstract class Exercise {
  String name;
  String description;
  double apexAngle;


  Exercise({
    required this.name,
    required this.description,
    required this.apexAngle,
  });


  MovementAnalysisResponse movementAnalysis(Map<PoseLandmarkType, PoseLandmark> posesLandmarks);
  MaxRangeResponse getGreaterRange(List<Pose>? max, List<Pose> current);
  bool isApexPosition(Map<PoseLandmarkType, PoseLandmark> posesLandmarks, List<Pose>? useAsApex);
  bool isRestPosition(Map<PoseLandmarkType, PoseLandmark> posesLandmarks);
  double showAngle(List<Pose>? pose);

  // Método para exibir informações detalhadas sobre o exercício
  void displayDetails() {
    print('Nome: $name');
    print('Descrição: $description');
  }
}

class MovementAnalysisResponse {
  bool error = false;
  String? errorMessage;
  bool endOfMovement = false;
  bool beginningOfMovement = false;

  MovementAnalysisResponse({
    required this.error,
    this.errorMessage,
    this.endOfMovement = false,
    this.beginningOfMovement = false,
  });
}

class MaxRangeResponse {
  bool isMaxRange;
  List<Pose>? pose;

  MaxRangeResponse({
    required this.isMaxRange,
    this.pose,
  });
}
