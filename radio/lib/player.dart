import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import 'controllers/RadioController.dart';
import 'helpers/Constants.dart';
import 'music_animation.dart';
import 'radioappbar.dart';
import 'styles/styles.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> with SingleTickerProviderStateMixin {
  RadioController radioController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const RadioAppBar(),
        body: Container(
            color: Styles.bkgColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Flexible(
                      child:
                          Text('Playing now', style: Styles.radioPlayerTitle)),
                  Spacer(),
                  Obx(() => radioController.isPlaying.value
                      ? SizedBox(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List<Widget>.generate(
                                10,
                                (index) => MusicAnimation(
                                    duration: Constants.duration[index % 5],
                                    color: Styles.musicColors[index % 4])),
                          ),
                        )
                      : SizedBox(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List<Widget>.generate(
                                10,
                                (index) => MusicAnimation(
                                    duration: Constants.duration[index % 5],
                                    color: Styles.musicColors[index % 4])),
                          ),
                        )),
                  Expanded(
                      child: Obx(
                    () => Marquee(
                      text: radioController.selectedRadioName
                              .toString()
                              .trim()
                              .isNotEmpty
                          ? radioController.selectedRadioName.toString().trim()
                          : 'RadioApp',
                      style: Styles.radioCodePlayer,
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      blankSpace: 200.0,
                      velocity: 80.0,
                      pauseAfterRound: Duration(seconds: 1),
                      startPadding: 5.0,
                      accelerationDuration: Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: Duration(milliseconds: 800),
                      decelerationCurve: Curves.easeOut,
                    ),
                  )),
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (radioController.selectedRadioIndex.value -
                                      1 >=
                                  0) {
                                if (radioController.isTopVoted.value) {
                                  radioController.selectedRadioIndex.value--;
                                  radioController.updateSelectedRadio(
                                      radioController.radioListTop[
                                          radioController
                                              .selectedRadioIndex.value],
                                      radioController.selectedRadioIndex.value);
                                } else {
                                  radioController.selectedRadioIndex.value--;
                                  radioController.updateSelectedRadio(
                                      radioController.radioList[radioController
                                          .selectedRadioIndex.value],
                                      radioController.selectedRadioIndex.value);
                                }
                              } else {
                                if (radioController.isTopVoted.value) {
                                  radioController.updateSelectedRadio(
                                      radioController.radioListTop[
                                          radioController.radioListTop.length -
                                              1],
                                      radioController.radioListTop.length - 1);
                                } else {
                                  radioController.updateSelectedRadio(
                                      radioController.radioList[
                                          radioController.radioList.length - 1],
                                      radioController.radioList.length - 1);
                                }
                              }

                              radioController.play();
                            },
                            icon: const Icon(
                              Icons.arrow_left_sharp,
                              color: Colors.white,
                              size: 56,
                            )),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (radioController.isPlaying.value) {
                                radioController.pause();
                              } else {
                                radioController.play();
                              }
                            },
                            icon: Obx(() => radioController.isPlaying.value
                                ? const Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                    size: 56,
                                  )
                                : const Icon(
                                    Icons.play_circle_fill_rounded,
                                    color: Colors.white,
                                    size: 56,
                                  ))),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (radioController.isTopVoted.value) {
                                if (radioController.selectedRadioIndex.value +
                                        1 <
                                    radioController.radioListTop.length) {
                                  radioController.selectedRadioIndex.value++;
                                  radioController.updateSelectedRadio(
                                      radioController.radioListTop[
                                          radioController
                                              .selectedRadioIndex.value],
                                      radioController.selectedRadioIndex.value);
                                } else {
                                  radioController.updateSelectedRadio(
                                      radioController.radioListTop[0], 0);
                                }
                              } else {
                                if (radioController.selectedRadioIndex.value +
                                        1 <
                                    radioController.radioList.length) {
                                  radioController.selectedRadioIndex.value++;
                                  radioController.updateSelectedRadio(
                                      radioController.radioList[radioController
                                          .selectedRadioIndex.value],
                                      radioController.selectedRadioIndex.value);
                                } else {
                                  radioController.updateSelectedRadio(
                                      radioController.radioList[0], 0);
                                }
                              }

                              radioController.play();
                            },
                            icon: const Icon(
                              Icons.arrow_right_sharp,
                              color: Colors.white,
                              size: 56,
                            )),
                      ],
                    ),
                  )
                ],
              )),
            )));
  }
}
