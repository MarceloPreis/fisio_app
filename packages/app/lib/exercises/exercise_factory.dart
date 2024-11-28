import 'exercise.dart';
import 'lateral_elevation.dart';

class ExerciseFactory {
  static Exercise createExercise(String type) {
    switch (type) {
      case 'lateral_elevation':
        return LateralElevation();

      default:
        throw ArgumentError('Tipo de exercício desconhecido: $type');
    }
  }
}
