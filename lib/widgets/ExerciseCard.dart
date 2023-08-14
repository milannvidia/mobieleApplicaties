import 'package:flutter/material.dart';
import '../fitnessLogic/Exercise.dart';
import 'SetTile.dart';

class ExerciseCard extends StatefulWidget {
  Exercise exercise;
  ExerciseCard({Key? key, required this.exercise}) : super(key: key);
  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late TextEditingController controller;
  @override
  void initState(){
    super.initState();
    controller= TextEditingController();
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.fitness_center),
                Text(
                  widget.exercise.name,
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.5),
                ),
                IconButton(onPressed: ()async{
                  final name=await openDialog();
                  setState(() {

                    widget.exercise.name=name!;
                  });
                },
                    icon: Icon(Icons.edit)),

                ElevatedButton(onPressed: ()=> setState((){
                  widget.exercise.sets.add(LiftSet(0,0));
                }), child: Text("Add set")),
              ],
            ),
            Container(
              height: 108,

              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.exercise.sets.map((e) => SetTile(set: e)).toList(),
              ),
            )
          ],
        ),
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

}

