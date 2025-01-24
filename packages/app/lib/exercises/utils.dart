import 'dart:math';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

checkAngle(
  Map<PoseLandmarkType, PoseLandmark> landmarks,
  PoseLandmarkType pointType1, 
  PoseLandmarkType pointType2, 
  PoseLandmarkType pointType3, 
  String axis,
  String operator, 
  double compareTo) {

  final PoseLandmark? point1 = landmarks[pointType1];
  final PoseLandmark? point2 = landmarks[pointType2];
  final PoseLandmark? point3 = landmarks[pointType3];

  if (point1 == null || point2 == null || point3 == null) {
    return true;
  }

  final double angle = calculateAngle(point1, point2, point3);

  switch (operator) {
    case '>':
      return angle > compareTo;
    case '<':
      return angle < compareTo;
    case '>=':
      return angle >= compareTo;
    case '<=':
      return angle <= compareTo;
    case '==':
      return angle == compareTo;
    default:
      throw ArgumentError('Operador desconhecido: $operator');
  }

}

double calculateAngle(PoseLandmark? point1, PoseLandmark? point2, PoseLandmark? point3) {

  if (point1 == null || point2 == null || point3 == null) return 0;

  double angle = atan2(point3.y - point2.y, point3.x - point2.x) - atan2(point1.y - point2.y, point1.x - point2.x);
  
  angle = angle * 180 / pi; // Convertendo para graus

  if (angle < 0) {
    angle += 360; // Ajustando o ângulo para o intervalo [0, 360]
  }

  if (angle > 180) {
    angle = 360 - angle; // Convertendo para o intervalo [0, 180]
  }

  return angle;
}

bool areTwoPointsAlmostCollinear(
    Map<PoseLandmarkType, PoseLandmark> landmarks,
    PoseLandmarkType pointType1,
    PoseLandmarkType pointType2,
    double tolerance) {
  final PoseLandmark? point1 = landmarks[pointType1];
  final PoseLandmark? point2 = landmarks[pointType2];

  if (point1 == null || point2 == null) {
    return false;
  }

  final double deltaX = (point2.x - point1.x).abs();
  final double deltaY = (point2.y - point1.y).abs();

  return deltaX <= tolerance && deltaY <= tolerance;
}


