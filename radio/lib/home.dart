import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:radio/models/RadioStation.dart';
import 'package:radio/player.dart';
import 'controllers/RadioController.dart';
import 'radioappbar.dart';
import 'styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RadioController radioController = Get.put(RadioController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: const RadioAppBar(),
            body: Container(
              color: Styles.bkgColor,
              child: Column(
                children: <Widget>[
                  const TabBar(indicatorColor: Styles.selectedColor, tabs: [
                    Tab(
                      child: Text('All radios', style: Styles.tabs),
                    ),
                    Tab(
                      child: Text('Top votes', style: Styles.tabs),
                    )
                  ]),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Container(
                            color: Styles.bkgColor,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(child: _getAllRadios())
                              ],
                            )),
                        Container(
                            color: Styles.bkgColor,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(child: _getTopRadios())
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  FutureBuilder<List<RadioStation>> _getAllRadios() =>
      FutureBuilder<List<RadioStation>>(
        future: radioController.getAllRadioStations(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            radioController.radioList.value = snapshot.data!;

            return GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemBuilder: ((context, index) {
                  return Obx(() => InkWell(
                      onTap: () {
                        radioController.updateSelectedRadio(
                            radioController.radioList[index], index);
                        radioController.play();
                        radioController.isTopVoted.value = false;
                        Get.to(() => const Player());
                      },
                      child: _buildCard(snapshot.data![index], index, false)));
                }));
          }
          return const Center(child: CircularProgressIndicator());
        },
      );

  FutureBuilder<List<RadioStation>> _getTopRadios() =>
      FutureBuilder<List<RadioStation>>(
        future: radioController.getTopVotesRadioStations(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            radioController.radioListTop.value = snapshot.data!;
            return GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemBuilder: ((context, index) {
                  return Obx(() => InkWell(
                      onTap: () {
                        radioController.updateSelectedRadio(
                            radioController.radioListTop[index], index);
                        radioController.play();
                        radioController.isTopVoted.value = true;
                        Get.to(() => const Player());
                      },
                      child: _buildCard(snapshot.data![index], index, true)));
                }));
          }
          return const Center(child: CircularProgressIndicator());
        },
      );

  Card _buildCard(RadioStation radio, int index, bool isTop) {
    return Card(
      color: radio.stationuuid
                  .toString()
                  .compareTo(radioController.selectedRadioID.value) ==
              0
          ? Styles.selectedColor
          : Styles.bkgColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: radio.stationuuid
                          .toString()
                          .compareTo(radioController.selectedRadioID.value) ==
                      0
                  ? Styles.selectedColor
                  : Styles.notSelectedColor,
              width: 2.0),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Marquee(
              text: radio.name!.isNotEmpty ? radio.name.toString() : 'NoName',
              style: radio.stationuuid
                          .toString()
                          .compareTo(radioController.selectedRadioID.value) ==
                      0
                  ? Styles.radioCode
                  : Styles.radioCodeNotSelected,
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 15,
              velocity: 80.0,
              pauseAfterRound: const Duration(seconds: 1),
              startPadding: 5.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 800),
              decelerationCurve: Curves.easeOut,
            ),
          ),
          Flexible(
            child: Center(
                child: Text(
                    radio.country.toString().isNotEmpty
                        ? radio.country.toString().trim()
                        : '-',
                    style: radio.stationuuid.toString().compareTo(
                                radioController.selectedRadioID.value) ==
                            0
                        ? Styles.radioName
                        : Styles.radioNameNotSelected,
                    textAlign: TextAlign.center)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60,
                child: IconButton(
                  onPressed: () {
                    if (radioController.isPlaying.value &&
                        radioController.selectedRadioID.value
                                .compareTo(radio.stationuuid.toString()) ==
                            0) {
                      radioController.pause();
                    } else {
                      radioController.updateSelectedRadio(
                          isTop
                              ? radioController.radioListTop[index]
                              : radioController.radioList[index],
                          index);
                      radioController.play();
                    }

                    //  Get.to(() => Player());
                  },
                  icon: radioController.selectedRadioID.value
                              .compareTo(radio.stationuuid.toString()) ==
                          0
                      ? radioController.isPlaying.value
                          ? const Icon(Icons.pause,
                              color: Colors.white, size: 40)
                          : const Icon(Icons.play_circle_outline,
                              color: Colors.white, size: 40)
                      : const Icon(Icons.play_circle_outline,
                          color: Colors.blueGrey, size: 40),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
