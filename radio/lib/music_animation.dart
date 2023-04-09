import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/RadioController.dart';

class MusicAnimation extends StatefulWidget {
  const MusicAnimation(
      {super.key, required this.duration, required this.color});

  final int duration;
  final Color color;

  @override
  State<MusicAnimation> createState() => _MusicAnimationState();
}

class _MusicAnimationState extends State<MusicAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  RadioController radioController = Get.find();
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInCubic);

    animation = Tween<double>(begin: 1, end: 100).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    animationController.repeat(reverse: true);
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: radioController.isPlaying.value ? animation.value : 5,
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(5)),
    );
  }
}
