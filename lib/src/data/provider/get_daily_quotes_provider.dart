import 'package:hidayah/src/data/models/common/state_model.dart';
import 'package:hidayah/src/data/models/dailyQuotes/daily_quotes_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';

class GetDailyQuotesProvider {
  Future<StateModel?> getDailyQuotes() async {
    final response = await ObjectFactory().apiClient.fetchDailyQuotes();
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<GetDailyQuotesReponse>.success(
          GetDailyQuotesReponse.fromJson(response.data));
    } else {
      return null;
    }
  }
}
