import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget{
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Stopwatch stopwatch=Stopwatch();
  bool startStop=false;
  late Timer timer;
  String elapsedTime='';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(elapsedTime),
          Row(
            children: [
              IconButton(onPressed: ()=>{startPauseTimer()}, icon: const Icon(Icons.play_arrow)),
              IconButton(onPressed: ()=>{resetTimer()}, icon: const Icon(Icons.square))
            ],
          )
        ],
      ),
    );
  }
  resetTimer(){
    stopwatch.stop();
    stopwatch.reset();
    setTime();
  }
  startPauseTimer() {
    if(startStop){
      stopwatch.stop();
      startStop=false;
      setTime();
    }else{
      startStop=true;
      stopwatch.start();
      timer = Timer.periodic(const Duration(milliseconds: 100), updateTime);
    }
  }
  setTime() {
    var timeSoFar = stopwatch.elapsedMilliseconds~/1000;
    setState(() {
      elapsedTime = intToTimeLeft(timeSoFar);
    });
  }
  void updateTime(Timer timer) {
    if (stopwatch.isRunning) {
      setTime();
    }else{timer.cancel();}
  }
}
String intToTimeLeft(int value) {
  int h, m, s;

  h = value ~/ 3600;
  m = ((value - h * 3600)) ~/ 60;
  s = value - (h * 3600) - (m * 60);

  String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();

  String minuteLeft =
  m.toString().length < 2 ? "0$m" : m.toString();

  String secondsLeft =
  s.toString().length < 2 ? "0$s" : s.toString();

  String result = "$hourLeft:$minuteLeft:$secondsLeft";

  return result;
}