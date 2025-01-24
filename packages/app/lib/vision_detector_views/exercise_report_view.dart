import 'package:flutter/material.dart';

import '../exercises/exercise_session.dart';

class ExerciseReportView extends StatelessWidget {
  final ExerciseSession exerciseSession;

  ExerciseReportView({required this.exerciseSession});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório do Exercício'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tempo (segundos): ${exerciseSession.currentTime}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Total de Repetições: ${exerciseSession.reps}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Repetições Incorretas: ${exerciseSession.totalReps - exerciseSession.correctExecutedReps}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Angulo Máximo: ${exerciseSession.exercise.showAngle(exerciseSession.maxRange).truncate()}°',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Deficit de movimento: ' + (exerciseSession.exercise.apexAngle - exerciseSession.exercise.showAngle(exerciseSession.maxRange).truncate()).toString() + '%',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
