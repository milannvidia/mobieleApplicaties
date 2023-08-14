import 'package:app2/fitnessLogic/Workout.dart';
import 'package:hive/hive.dart';

class LocalStorage{
 var box=Hive.box("workouts");
 var unsavedWorkouts= Hive.box("unsaved");
 LocalStorage(){
 }

 void saveWorkout(Workout workout){
   if(workout.documentId==null){
     print("got no docId");
     unsavedWorkouts.put(workout.title,workout.toJson());

   }else{
     box.put(workout.documentId,workout.toJson());
   }
 }

  void saveWorkouts(List<Workout> workouts) {
   workouts.forEach((element) {
     saveWorkout(element);
   });
  }

}