import 'package:app2/dataAndLogin/Userdata.dart';
import 'package:flutter/material.dart';
import '../fitnessLogic/Exercise.dart';
import '../fitnessLogic/Workout.dart';
import '../widgets/ExerciseCard.dart';
import '../widgets/TimerWidget.dart';

class WorkoutScreen extends StatefulWidget {
  final Workout workout;
  final UserData userdata;
  final Function() buildParent;

  WorkoutScreen({Key? key, required this.workout, required this.userdata, required this.buildParent}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController controller;
  final List<AppLifecycleState> _stateHistoryList = <AppLifecycleState>[];
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (WidgetsBinding.instance.lifecycleState != null) {
      _stateHistoryList.add(WidgetsBinding.instance.lifecycleState!);
    }
    controller= TextEditingController();
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.workout.title),
            IconButton(onPressed: ()async{
              final name=await openDialog();
              print(name);
              setState(() {
                widget.workout.title=name!;

              });
            }, icon: Icon(Icons.edit))
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 5,
              children:
              widget.workout.exercises.map((e) => ExerciseCard(exercise: e,)).toList(),
            ),
          ),
          ElevatedButton(onPressed:()=> setState(() {
            widget.workout.exercises.add(Exercise(''));
          }), child: Text("Add exercise"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          _formKey.currentState?.save();
          widget.userdata.saveWorkout(widget.workout);
          Navigator.of(context).pop();
          widget.buildParent();

        },
      ),
    );
  }
  Future<String?> openDialog() => showDialog<String>(
    context: context,
    builder: (context)=> AlertDialog(
      title: Text("Edit name"),
      content: TextField(
        autofocus: true,
        decoration: const InputDecoration(hintText: "Example"),
        controller: controller,
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(controller.text);

        }, child: Text("OK")),
        TextButton(onPressed: (){

          Navigator.of(context).pop();
        }, child: Text("Cancel"))
      ],

    ),
  );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state==AppLifecycleState.inactive){
      widget.userdata.saveToCloud();
    }
  }

}
