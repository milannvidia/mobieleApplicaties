class Exercise{
  late String name;
  late List<LiftSet> sets=[];

  Exercise(e1){
    name=e1;
  }

  toJSON() => {
    "name": name,
    "sets": setMap()
  };
  Map<String, dynamic> setMap() {
    Map<String, dynamic> map = {};
    for(var i=0; i<sets!.length; i++){
      map[i.toString()] = sets![i].toJSON();
    }
    return map;
  }


}

class LiftSet {
  late int reps;
  late double weight;

  LiftSet(double i, int j){
    weight=i;
    reps=j;

  }

  toJSON() => {
    "amountOfReps": reps,
    "amountOfKg": weight,
  };
}