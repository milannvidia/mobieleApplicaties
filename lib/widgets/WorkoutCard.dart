import 'package:animations/animations.dart';
import 'package:app2/dataAndLogin/Userdata.dart';
import 'package:flutter/material.dart';

import '../fitnessLogic/Workout.dart';
import '../screens/WorkoutScreen.dart';

class WorkoutCard extends StatelessWidget{
  final Workout workout;
  final UserData userData;
  final Function() buildParent;
  const WorkoutCard({Key? key, required this.workout, required this.userData, required this.buildParent}): super(key: key);

  @override
  Widget build(context) {
    return  OpenContainer(
      closedShape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(15),

      ),
      closedBuilder: (_,openContainer){
        return Card(
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(workout.title!),
                    const Text('Amount off exercises: '),
                  ],
                ),
                Column(
                  children: [
                    const Text(''),
                    Text(workout.exercises!.length.toString()),
                  ],
                ),

                IconButton(icon:Icon( Icons.delete), onPressed: (){
                  userData.delete(workout);
                  buildParent();
                },),
              ],
            ),
          ),
        );
      },
      openBuilder: (_,closedBuilder){
        return WorkoutScreen(workout: workout, userdata: userData,buildParent: buildParent );
      },
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}