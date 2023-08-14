// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../fitnessLogic/Exercise.dart';
//
//
//
// class AddExercisePage extends StatefulWidget {
//   final Function(Exercise) addExercise;
//
//   const AddExercisePage({Key? key, required this.addExercise}) : super(key: key);
//
//   @override
//   State<AddExercisePage> createState() => _AddExercisePageState();
// }
//
// class _AddExercisePageState extends State<AddExercisePage> {
//   final CollectionReference _exercises =
//       FirebaseFirestore.instance.collection('exercises');
//   // final hiveService = HiveService();
//   late TextEditingController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey,
//         appBar: AppBar(
//           backgroundColor: Colors.black54,
//           title: const Text("add exercise"),
//           centerTitle: true,
//         ),
//         body: StreamBuilder(
//           stream: _exercises.snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//             if (streamSnapshot.hasData) {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       // itemCount: streamSnapshot.data!.docs.length + hiveService.getCustomExercises().length,
//                       //number of rows
//                       itemBuilder: (context, index) {
//                         if(index < streamSnapshot.data!.docs.length){
//                           final DocumentSnapshot documentSnapshot =
//                           streamSnapshot.data!.docs[index];
//                           return InkWell(
//                             onTap: () {
//                               final exercise =
//                               Exercise(documentSnapshot['name']);
//                               widget.addExercise(exercise);
//                               Navigator.of(context).pop();
//                             },
//                             child: Card(
//                               margin: const EdgeInsets.all(10),
//                               child: ListTile(
//                                 title: Text(documentSnapshot['name']),
//                               ),
//                             ),
//                           );
//                         } else {
//                           int index1 = index - streamSnapshot.data!.docs.length;
//                           // String name = hiveService.getCustomExercise(index1);
//                           return InkWell(
//                             onTap: () {
//                               final exercise =
//                               Exercise("hii");
//                               widget.addExercise(exercise);
//                               Navigator.of(context).pop();
//                             },
//                             child: const Card(
//                               color: Colors.blueGrey,
//                               margin: EdgeInsets.all(10),
//                               child: ListTile(
//                                 title: Text("hii",style: TextStyle(color: Colors.black)),
//                               ),
//                             ),
//                           );
//                         }
//
//                       },
//                     ),
//                   ),
//                   ElevatedButton(
//                       onPressed: () {
//                         showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                                   title: const Text("custom exercise"),
//                                   content: TextField(
//                                     decoration: const InputDecoration(hintText: "enter name of custom exercise"),
//                                     controller: controller,
//                                   ),
//                                   actions: [
//                                     TextButton(
//                                         onPressed: () {
//                                           // hiveService.saveCustomExercise(controller.text);
//                                           setState(() {});
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: const Text("submit"))
//                                   ],
//                                 ));
//                       },
//                       child: const Text("add custom exercise"))
//                 ],
//               );
//             }
//
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ));
//   }
// }
