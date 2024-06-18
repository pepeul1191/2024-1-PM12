import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/models/entities/Usuario.dart';
import 'package:ulimagym/services/body_part_service.dart';
import '../../models/entities/BodyPart.dart';
import '../../models/entities/Exercise.dart';
import '../../services/exercise_service.dart';

class RoutineController extends GetxController {
  RxList<BodyPart> bodyParts = <BodyPart>[].obs;
  RxList<Exercise> exercises = <Exercise>[].obs;
  List<Exercise> exercisesOriginal = <Exercise>[];
  Rx<BodyPart?> selectedBodyPart = Rx<BodyPart?>(null);
  BodyPartService bobyPartService = new BodyPartService();
  RxString bodyPartSelectedText = "Seleccione una parte del cuerpo".obs;
  BodyPartService bodyPartService = BodyPartService();
  ExerciseService exerciseService = ExerciseService();
  Usuario user = Usuario.empty();

  void fillBodyParts() async {
    List<BodyPart>? bodyParts = await bobyPartService.fetchAll(user.miembroId);
    if (bodyParts == null) {
      print('Hubo un error en traer los datos del servidor');
    } else if (bodyParts.isEmpty) {
      print('No hay datos en la respuesta');
    } else {
      this.bodyParts.value = bodyParts;
    }
  }

  void setSelectedBodyPart(BodyPart? newValue) {
    selectedBodyPart.value = newValue;
  }

  void bodyPartSelected(BuildContext context, BodyPart selectedBodyPart) async {
    this.bodyPartSelectedText.value = selectedBodyPart.name;
    this.exercises.clear();
    List<Exercise>? exercises = await exerciseService.fetchAll(
        bodyPartId: selectedBodyPart.id, memberId: user.miembroId);
    if (exercises == null) {
      print('Hubo un error en traer los datos del servidor');
    } else if (exercises.isEmpty) {
      print('No hay datos en la respuesta');
    } else {
      this.exercises.value = exercises;
    }
  }

  void fetchExercises() async {
    List<Exercise>? exercises =
        await exerciseService.fetchAll(memberId: user.miembroId);
    print(exercises);
    if (exercises == null) {
      print('Hubo un error en traer los datos del servidor');
    } else if (exercises.isEmpty) {
      print('No hay datos en la respuesta');
    } else {
      this.exercises.value = exercises;
      if (this.exercisesOriginal.isEmpty) {
        this.exercisesOriginal = exercises;
      }
    }
  }

  void resetBodyPartSeleccion() {
    this.exercises.clear();
    this.fetchExercises();
    this.bodyPartSelectedText.value = "Seleccione una parte del cuerpo";
  }
}
