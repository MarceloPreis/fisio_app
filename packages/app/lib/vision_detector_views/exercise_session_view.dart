import 'package:flutter/material.dart';

import '../exercises/exercise.dart';
import '../exercises/exercise_factory.dart';
import '../exercises/exercise_session.dart';
import 'exercise_report_view.dart';
import 'pose_detector_view.dart';

class ExerciseSessionView extends StatefulWidget {
  
  ExerciseSessionView({
    required this.exercise
  });

  final Exercise exercise;

  @override
  State<ExerciseSessionView> createState() => _ExerciseSessionViewState();
}

class _ExerciseSessionViewState extends State<ExerciseSessionView> {
  int reps = 15;
  int time = 30;
  final TextEditingController _repsController = TextEditingController(text: '15');
  final TextEditingController _timeController = TextEditingController(text: '30');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _repsController,
                    decoration:
                      InputDecoration(labelText: 'Quantidade de Repetições'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _timeController,
                    decoration:
                        InputDecoration(labelText: 'Tempo Máximo (segundos)'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_repsController.text.isNotEmpty &&
                          _timeController.text.isNotEmpty) {
                        int reps = int.parse(_repsController.text);
                        int time = int.parse(_timeController.text);

                        final ExerciseSession session = ExerciseSession(
                                        exercise: widget.exercise,
                                        totalReps: reps,
                                        duration: time);


                        session.onStop = () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExerciseReportView(exerciseSession: session))
                            );

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PoseDetectorView(session: session,))
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Por favor, preencha todos os campos')));
                      }
                    },
                    style: ButtonStyle(elevation: MaterialStatePropertyAll(4)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Confirmar '),
                          Icon(Icons.check_circle_outline, color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
