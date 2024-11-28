import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import './exercise.dart';
import 'exercise_rule.dart';
import 'utils.dart';

class LateralElevation extends Exercise {
  LateralElevation() : super (
      name: 'Elevação Lateral',
      description: 'Exercício para fortalecer os ombros',
      duration: 15,
      intensity: 'Média',
      caloriesBurned: 50,
    );

    @override
    MovementAnalysisResponse movementAnalysis(Map<PoseLandmarkType, PoseLandmark> landmarks) {
      for (final rule in getRules()) {
        if (!rule.test(landmarks)) {
          return MovementAnalysisResponse(
              error: true,
              errorMessage: rule.errorMessage,
          );
        }

      }

      return MovementAnalysisResponse(error: false);
    }

    @override
    List<ExerciseRule> getRules() {

      final List<ExerciseRule> rules = [
        ExerciseRule(
            errorMessage: "O pulso e cutovelo esquerdos não podem ultrapassar a altura do ombro",
            test:(Map<PoseLandmarkType, PoseLandmark> landmarks) {
              return checkAngle(
                  landmarks, 
                  PoseLandmarkType.leftShoulder,
                  PoseLandmarkType.leftElbow,
                  PoseLandmarkType.leftHip,
                  '',
                  '>',
                  120.0,
                );
            },
        ),
        // ExerciseRule(
        //     rule: 'A pessoa deve estar em movimento',
        //     violation: false,
        // ),
        // ExerciseRule(
        //     rule: 'O exercício deve ser feito com uma mão no chão',
        //     violation: true,
        // ),
        // ExerciseRule(
        //     rule: 'O exercício deve ser feito com uma mão em um dos ombros',
        //     violation: false,
        // )
      ];

      return rules;
    }
}