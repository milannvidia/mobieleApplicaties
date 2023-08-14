import 'dart:async';
import 'dart:io';
import 'package:app2/dataAndLogin/LocalStorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../fitnessLogic/Exercise.dart';
import '../fitnessLogic/Workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserData {
  bool localDataChanged = true;
  List<Workout>? workouts;
  LocalStorage localStorage = LocalStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  UserData() {}

  getWorkoutFromJSON(var element) {
    final res = element.data();
    Workout workout =
        Workout(title: element['title'], userId: element['userId']);
    workout.documentId = element.id;
    Map<String, dynamic> exercisesJson = res['exercises'];
    List<Exercise> exerciseList = [];

    for (var e1 in exercisesJson.values) {
      Map<String, dynamic> exerciseJson = e1;
      List<LiftSet> sets = [];
      Map<String, dynamic> setsJson = exerciseJson['sets'];
      for (var e2 in setsJson.values) {
        sets.add(LiftSet(e2['amountOfKg'].toDouble(), (e2['amountOfReps'])));
      }
      Exercise exercise = Exercise(e1['name']);
      exercise.sets = sets;
      exerciseList.add(exercise);
    }

    workout.exercises = exerciseList;
    return workout;
  }

  getWorkoutFromUnsaved(var element) {
    final res = element;
    Workout workout =
        Workout(title: element['title'], userId: element['userId']);
    List<Exercise> exerciseList = [];
    if (res['exercises'].toString() != "{}") {
      Map<String, dynamic> exercisesJson = res['exercises'];
      for (var e1 in exercisesJson.values) {
        Map<String, dynamic> exerciseJson = e1;
        List<LiftSet> sets = [];
        Map<String, dynamic> setsJson = exerciseJson['sets'];
        for (var e2 in setsJson.values) {
          sets.add(LiftSet(e2['amountOfKg'].toDouble(), (e2['amountOfReps'])));
        }
        Exercise exercise = Exercise(e1['name']);
        exercise.sets = sets;
        exerciseList.add(exercise);
      }
    }

    workout.exercises = exerciseList;
    return workout;
  }

  Future<List<Workout>> getWorkoutsFireStore() async {
    List<Workout> workouts = [];
    var data = await firestore
        .collection('workouts')
        .where('userId', isEqualTo: user?.uid)
        .get();

    data.docs.forEach((element) {
      workouts.add(getWorkoutFromJSON(element));
    });
    localDataChanged = false;
    localStorage.saveWorkouts(workouts);

    return workouts;
  }

  Future<List<Workout>?> getWorkouts(bool refresh) async {
    if (workouts != null && !refresh) {
      return workouts;
    } else {
      List<Workout> workouts = await getWorkoutsFireStore();
      if (localStorage.unsavedWorkouts.isNotEmpty) {
        localStorage.unsavedWorkouts.values.forEach((element) {
          workouts.add(getWorkoutFromUnsaved(element));
        });
      }
      this.workouts = workouts;
      return workouts;
    }
  }

  // postWorkout() async {
  //   await firestore.collection("workouts").add(
  //       {"exercises":{"0":{"sets":{"0":{"amountOfReps":10,"amountOfKg":100},"1":{"amountOfReps":0,"amountOfKg":0},"2":{"amountOfReps":0,"amountOfKg":0}},"name":"barbell back squat"},"1":{"sets":{"0":{"amountOfReps":0,"amountOfKg":0}},"name":"dead lift"}},
  //         "title":"full body 1 ",
  //         "userId":user.uid,}
  //   );
  // }
  saveWorkout(Workout workout) async {
    workouts!.add(workout);
    localStorage.saveWorkout(workout);
    if (workout.documentId == null) {
      await firestore
          .collection("workouts")
          .add(workout.toJson())
          .then((value) => localStorage.unsavedWorkouts.delete(workout.title));
    } else {
      await firestore
          .collection("workouts")
          .doc(workout.documentId)
          .set(workout.toJson());
    }
  }

  saveToCloud() {
    print(localStorage.unsavedWorkouts.length);
    print(localStorage.box.length);
    localStorage.unsavedWorkouts.values.forEach((workout) async {
      await firestore.collection("workouts").add(workout).then(
          (value) => localStorage.unsavedWorkouts.delete(workout['title']));
    });
    localStorage.box.values.forEach((workout) async {
      await firestore
          .collection("workouts")
          .doc(workout['documentId'])
          .set(workout);
    });
  }

  void delete(Workout workout) async {
    workouts!.remove(workout);
    if (workout.documentId == null) {
      localStorage.unsavedWorkouts.delete(workout.title);
    } else {
      localStorage.box.delete(workout.documentId);
      await firestore.collection("workouts").doc(workout.documentId).delete();
    }
  }

  getProfilePictureURL()  async{
    var downloadURL = await storage.ref('profile_pictures/${user!.uid}').getDownloadURL();
    print(downloadURL);
    return downloadURL;
  }

  Future<void> changeProfilePicture(String path) async{
    File file = File(path);
    try {
      await storage
          .ref('profile_pictures/${user!.uid}')
          .putFile(file);
    }  catch (e) {
      print(e);
    }
  }
}
