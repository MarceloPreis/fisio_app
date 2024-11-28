import 'dart:ffi';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'exercise_rule.dart';

abstract class Exercise {
  String name;
  String description;
  int duration; // Duração em minutos
  String intensity; // Baixa, Média, Alta
  int caloriesBurned;

  Exercise({
    required this.name,
    required this.description,
    required this.duration,
    required this.intensity,
    required this.caloriesBurned,
  });


  MovementAnalysisResponse movementAnalysis(Map<PoseLandmarkType, PoseLandmark> posesLandmarks);

  // Método para exibir informações detalhadas sobre o exercício
  void displayDetails() {
    print('Nome: $name');
    print('Descrição: $description');
    print('Duração: $duration minutos');
    print('Intensidade: $intensity');
    print('Calorias Queimadas: $caloriesBurned kcal');
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
