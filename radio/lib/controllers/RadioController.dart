import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:convert';

import 'package:radio/models/RadioStation.dart';

import '../helpers/Constants.dart';
import 'package:http/http.dart' as http;

class RadioController extends GetxController {
  final selectedRadioID = "".obs;
  final selectedRadioIndex = 0.obs;
  final selectedRadioName = "".obs;
  final selectedRadioCountry = "".obs;
  final selectedRadioURL = "".obs;
  final isPlaying = false.obs;
  final isTopVoted = false.obs;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final radioList = [].obs;
  final radioListTop = [].obs;

  void updateSelectedRadio(RadioStation radio, int index) {
    selectedRadioID.value = radio.stationuuid.toString();
    selectedRadioName.value = radio.name.toString();
    selectedRadioCountry.value = radio.country.toString();
    selectedRadioURL.value = radio.urlresolver.toString();
    selectedRadioIndex.value = index;
  }

  Future<void> play() async {
    await _audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(selectedRadioURL.toString())));
    _audioPlayer.play();
    isPlaying.value = true;
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    isPlaying.value = false;
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<List<RadioStation>> getAllRadioStations() async {
    try {
      var url = Uri.parse(Constants.API_ALLRADIOSTATIONS_URL);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        List dataList = data;
        if (data == null) {
          throw Future.error('Data not found');
        }

        return dataList.map((radio) => RadioStation.fromJson(radio)).toList();
      } else {
        throw Future.error(
            'Request failed with status:  ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception :  ${e.toString()}');
    }
  }

  Future<List<RadioStation>> getTopVotesRadioStations() async {
    try {
      var url = Uri.parse(Constants.API_TOPVOTESRADIOSTATIONS_URL);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        List dataList = data;
        if (data == null) {
          throw Future.error('Data not found');
        }

        return dataList.map((radio) => RadioStation.fromJson(radio)).toList();
      } else {
        throw Future.error(
            'Request failed with status:  ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception :  ${e.toString()}');
    }
  }
}
