import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import './exercise.dart';
import 'exercise_rule.dart';
import 'utils.dart';

class LateralElevation extends Exercise {
  LateralElevation() : super (
      name: 'Elevação Lateral',
      description: 'Exercício para fortalecer os ombros',
      apexAngle: 85,
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
    bool isApexPosition(Map<PoseLandmarkType, PoseLandmark> landmarks, List<Pose>? useAsApex) {
      double apex = apexAngle;

      if (useAsApex != null) {
        apex = calculateAngle(
            useAsApex[0].landmarks[PoseLandmarkType.rightElbow],
            useAsApex[0].landmarks[PoseLandmarkType.rightShoulder],
            useAsApex[0].landmarks[PoseLandmarkType.rightHip]);
      }

      return checkAngle(
        landmarks,
        PoseLandmarkType.rightElbow,
        PoseLandmarkType.rightShoulder,
        PoseLandmarkType.rightHip,
        '',
        '>=',
        apex,
      );
    }

    @override
    bool isRestPosition(Map<PoseLandmarkType, PoseLandmark> landmarks) {
      return checkAngle(
        landmarks,
        PoseLandmarkType.rightElbow,
        PoseLandmarkType.rightShoulder,
        PoseLandmarkType.rightHip,
        '',
        '<=',
        30,
      );
    }

    @override
    MaxRangeResponse getGreaterRange(List<Pose>? max, List<Pose>? current) {
      
      if (max == null || current == null) {
        return MaxRangeResponse(isMaxRange: false, pose: null);
      }

      double maxAngle = calculateAngle(
          max[0].landmarks[PoseLandmarkType.rightElbow],
          max[0].landmarks[PoseLandmarkType.rightShoulder],
          max[0].landmarks[PoseLandmarkType.rightHip]);

      double currentAngle = calculateAngle(
          current[0].landmarks[PoseLandmarkType.rightElbow],
          current[0].landmarks[PoseLandmarkType.rightShoulder],
          current[0].landmarks[PoseLandmarkType.rightHip]);
          
      bool isMaxRange = maxAngle < currentAngle;

      return MaxRangeResponse(isMaxRange: isMaxRange, pose: isMaxRange ? current : max );
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

    double showAngle(List<Pose>? pose ) {
      if (pose == null) {
        return 0.0;
      }
      
      double angle = calculateAngle(
          pose[0].landmarks[PoseLandmarkType.rightElbow],
          pose[0].landmarks[PoseLandmarkType.rightShoulder],
          pose[0].landmarks[PoseLandmarkType.rightHip]);
      
      return angle;
    }
}