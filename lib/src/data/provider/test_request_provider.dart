
import 'package:flutter/material.dart';
import 'package:hidayah/src/data/models/prayer_time_response.dart';
import 'package:hidayah/src/data/models/quran_request.dart';
import 'package:hidayah/src/data/models/quran_request_response.dart';

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';

class TestRequestProvider{

  ///fetch quran request
  Future<StateModel> quranFetchFiltered(QuranRequest request) async {
    final response = await ObjectFactory().apiClient.quranFetchFiltered(request);
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<QuranRequestResponse>.success(QuranRequestResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }
  
  Future<StateModel?> getPrayerTimesProvider() async {
    final response = await ObjectFactory().apiClient.getPrayerTimes();
    print(response.toString());
    if(response.statusCode == 200) {
      return StateModel<PrayerTimeResponse>.success(
        PrayerTimeResponse.fromJson(response.data)
      );
    } else{
      return null;
    }
  }





}