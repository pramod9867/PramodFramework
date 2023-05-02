import 'package:flutter/material.dart';
typedef onButtonPressed =Function(int index);

class InheritedWrapper extends StatefulWidget {
  final Widget child;
  final onButtonPressed buttonPressed;
  final int initialCount;
  InheritedWrapper({Key? key, required this.child,required this.buttonPressed,required this.initialCount}) : super(key: key);

  static InheritedWrapperState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedCounter>())!.data;
  }

  @override
  InheritedWrapperState createState() => InheritedWrapperState();
}

class InheritedWrapperState extends State<InheritedWrapper> {
late int counter;
  @override
  void initState() {
     counter = widget.initialCount;
    super.initState();
  }

  void incrementCounter() {
    setState(() {
      counter+=1;

    });
    widget.buttonPressed(counter);
  }

  void decrementCounter(){
    setState(() {
      counter-=1;


    });
    widget.buttonPressed(counter);
  }

  @override
  Widget build(BuildContext context) {
    return InheritedCounter(child: this.widget.child, data: this,counter:counter);
  }
}

class InheritedCounter extends InheritedWidget {
  InheritedCounter({Key? key, required this.child, required this.data,required this.counter})
      : super(key: key, child: child);

  final Widget child;
  final int counter;
  final InheritedWrapperState data;

  @override
  bool updateShouldNotify(InheritedCounter oldWidget) {
    return counter != oldWidget.counter;
  }
}