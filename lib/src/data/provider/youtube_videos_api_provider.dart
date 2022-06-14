

import '../../shared_pref/object_factory.dart';
import '../models/common/state_model.dart';
import '../models/youtube_videos/youtube_videos_response.dart';

class YoutubeVideosApiProvider{
  Future<StateModel> fetchYouTubeVideos() async {
    final response = await ObjectFactory().apiClient.fetchYouTubeVideos( );
    print("response" + response.toString());
    if (response.statusCode == 200) {
      // ObjectFactory().prefs.saveCompanyBaseUrl(baseUrl: GetBaseUrlResponse.fromJson(response.data).data[0].restaurantCrmUrl);
      return StateModel<YoutubeVideosResponse>.success(YoutubeVideosResponse.fromJson(response.data));
    } else {
      return StateModel<String>.error("Error Occurred");
    }
  }
}