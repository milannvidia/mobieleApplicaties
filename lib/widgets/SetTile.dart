import 'package:flutter/material.dart';
import '../fitnessLogic/Exercise.dart';

class SetTile extends StatelessWidget{
  final LiftSet set;
  const SetTile({Key? key, required this.set}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                initialValue: set.reps.toString(),
                keyboardType: TextInputType.number,
                onSaved: (String? value){
                  set.reps=int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: set.weight.toString(),
                keyboardType: TextInputType.number,
                onSaved: (String? value){
                  set.weight=double.parse(value!);
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}