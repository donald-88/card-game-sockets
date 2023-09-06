import 'dart:async';

import 'package:flutter/material.dart';

class SessionTimeoutListener extends StatefulWidget {
  Widget child;
  Duration duration;
  VoidCallback onTimeOut;
  SessionTimeoutListener({super.key, required this.child, required this.duration, required this.onTimeOut});

  @override
  State<SessionTimeoutListener> createState() => _SessionTimeoutListenerState();
}

class _SessionTimeoutListenerState extends State<SessionTimeoutListener> {

  Timer? _timer;
  _startTimer(){
    print("Timer reset");
    if(_timer != null){
      _timer?.cancel();
      _timer = null;
    }

    _timer = Timer(widget.duration, () {
      print("Elapse time");
      widget.onTimeOut();
     });
  }

  @override
  void initState() {
    // TODO: implement initState
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(_timer != null){
      _timer?.cancel();
      _timer = null;
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_){
        _startTimer();
      },
      child: widget.child,
    );
  }
}