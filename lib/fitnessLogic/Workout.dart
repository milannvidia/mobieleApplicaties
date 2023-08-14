import 'Exercise.dart';

class Workout{
  String? documentId;
  String userId;
  String title='';
  List<Exercise> exercises=[];
  Workout({required this.userId, required this.title});

  Map<String, dynamic> toJson() => {
    "documentId":documentId,
    "userId": userId,
    "title": title,
    "exercises": exerciseMap()
  };

  Map<String, dynamic> exerciseMap() {
    Map<String, dynamic> map = {};
    for(var i=0; i<exercises!.length; i++){
      map[i.toString()] = exercises![i].toJSON();
    }
    return map;
  }

  @override
  String toString() {
    return 'Workout{documentId: $documentId, userId: $userId, title: $title, exercises: $exercises}';
  }


}
