import 'package:app2/screens/WorkoutScreen.dart';
import 'package:flutter/material.dart';
import 'package:app2/fitnessLogic/Workout.dart';
import 'package:animations/animations.dart';
import '../widgets/WorkoutCard.dart';
import '../dataAndLogin/Userdata.dart';

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  UserData userData = UserData();

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userData.getWorkouts(false),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Workout> workouts = snapshot.data!;
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(5),
                child: (workouts.isNotEmpty)
                    ? ListView(
                        children: workouts
                            .asMap()
                            .entries
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: WorkoutCard(
                                      workout: e.value,
                                      userData: userData,
                                      buildParent: () {
                                        setState(() {
                                          build(context);
                                        });
                                      }),
                                ))
                            .toList(),
                      )
                    : Center(child: Text("Much empty")),
              ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                      onPressed: () {
                        userData.getWorkouts(true);
                      },
                      child: Icon(Icons.refresh)),
                  OpenContainer(
                    closedBuilder: (_, openBuilder) {
                      return FloatingActionButton(
                        onPressed: openBuilder,
                        child: const Icon(Icons.add),
                      );
                    },
                    transitionType: ContainerTransitionType.fade,
                    transitionDuration: const Duration(milliseconds: 500),
                    closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    openBuilder: (_, closedBuilder) {
                      return WorkoutScreen(
                          userdata: userData,
                          workout: Workout(
                              userId: userData.user!.uid, title: "New workout"),
                          buildParent: () {
                            setState(() {
                              build(context);
                            });
                          });
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
                child: Container(
                    width: 100,
                    height: 100,
                    child: const CircularProgressIndicator()));
          }
        });
  }
}
