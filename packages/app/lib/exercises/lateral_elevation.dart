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
    bool isApexPosition(Map<PoseLandmarkType, PoseLandmark> landmarks) {
      bool leftArm = checkAngle(
        landmarks,
        PoseLandmarkType.leftElbow,
        PoseLandmarkType.leftShoulder,
        PoseLandmarkType.leftHip,
        '',
        '>=',
        85,
      );

      bool rightArm = checkAngle(
        landmarks,
        PoseLandmarkType.rightElbow,
        PoseLandmarkType.rightShoulder,
        PoseLandmarkType.rightHip,
        '',
        '>=',
        85,
      );

      return leftArm && rightArm;
    }

    @override
    bool isRestPosition(Map<PoseLandmarkType, PoseLandmark> landmarks) {
      bool leftArm = checkAngle(
        landmarks,
        PoseLandmarkType.leftElbow,
        PoseLandmarkType.leftShoulder,
        PoseLandmarkType.leftHip,
        '',
        '<=',
        30,
      );

      bool rightArm = checkAngle(
        landmarks,
        PoseLandmarkType.rightElbow,
        PoseLandmarkType.rightShoulder,
        PoseLandmarkType.rightHip,
        '',
        '<=',
        30,
      );

      return leftArm && rightArm;
    }

    List<ExerciseRule> getRules() {

      final List<ExerciseRule> rules = [
        ExerciseRule(
            errorMessage: "O pulso e cutovelo esquerdos não podem ultrapassar a altura do ombro",
            test:(Map<PoseLandmarkType, PoseLandmark> landmarks) {
              return checkAngle(
                  landmarks, 
                  PoseLandmarkType.leftElbow,
                  PoseLandmarkType.leftShoulder,
                  PoseLandmarkType.leftHip,
                  '',
                  '<',
                  100.0,
                );
            },
        ),
        ExerciseRule(
            errorMessage: "O pulso e cutovelo direitos não podem ultrapassar a altura do ombro",
            test:(Map<PoseLandmarkType, PoseLandmark> landmarks) {
              return checkAngle(
                  landmarks, 
                  PoseLandmarkType.rightElbow,
                  PoseLandmarkType.rightShoulder,
                  PoseLandmarkType.rightHip,
                  '',
                  '<',
                  100.0,
                );
            },
        ),
        // ExerciseRule(
        //     errorMessage: "Mantenha o pés alinhados com o quadril",
        //     test:(Map<PoseLandmarkType, PoseLandmark> landmarks) {
        //       return areTwoPointsAlmostCollinear(
        //           landmarks, 
        //           PoseLandmarkType.rightKnee,
        //           PoseLandmarkType.rightHip,
        //           100.0,
        //         );
        //     },
        // ),
      ];

      return rules;
    }
}