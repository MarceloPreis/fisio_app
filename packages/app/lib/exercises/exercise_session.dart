import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../utils/timer_service.dart';
import 'exercise.dart';

class ExerciseSession {
  Exercise exercise;
  int duration; // Duração em segundos
  int totalReps;
  int reps = 0;
  int currentTime = 0;
  int _maxRange = 0;
  int correctExecutedReps = 0;
  bool _findApexPosition = false;
  bool _findRestPosition = false;
  bool _registerMaxRange = false;
  String errorMessage = '';
  List<Pose>? lastPose;
  List<Pose>? maxRange;

  void Function()? onStop;

  ExerciseSession({
    required this.exercise,
    required this.totalReps,
    required this.duration,
    this.onStop,
  });

  void startSession() {
    final TimerService timerService = TimerService(onTick: (timer) {
        currentTime = timer.elapsedSeconds;

        if (timer.elapsedSeconds == duration) {
          timer.stop();
          stopSession();
        }
      });

    timerService.start();
  }

  void stopSession() {
    onStop?.call();
  }

  void processPoses(List<Pose> poses) {
    if (poses.isEmpty) return;

    final MovementAnalysisResponse analysis = exercise.movementAnalysis(poses[0].landmarks);
    
    if (analysis.error) {
      errorMessage = analysis.errorMessage ?? 'Erro Desconhecido!';
    } else {
      errorMessage = '';
    }
    maxRange ??= poses;
    
    final MaxRangeResponse maxRangeResponse = exercise.getGreaterRange(maxRange, poses);
    if (maxRangeResponse.isMaxRange) {
      maxRange = maxRangeResponse.pose;

      _findApexPosition = false;
      // _findRestPosition = true;

    } else {

      if (!_findRestPosition) {
        _findApexPosition = true;
      }

    }

    if (_findApexPosition) {
      if (exercise.isApexPosition(poses[0].landmarks, maxRange)) {
        reps++;

        if (!analysis.error) {
          correctExecutedReps++;
        }

        _findApexPosition = false;
        _findRestPosition = true;
      }
    } else {
      _findRestPosition = true;
    }

    if (_findRestPosition && exercise.isRestPosition(poses[0].landmarks)) {
      _findApexPosition = true;
      _findRestPosition = false;
    }

    if (reps >= totalReps) {
      stopSession();
    }

    lastPose = poses;
  }
}
