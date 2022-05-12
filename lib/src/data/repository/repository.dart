

import 'package:hidayah/src/data/models/Hadith/hadith_of_the_day_response.dart';
import 'package:hidayah/src/data/models/common/state_model.dart';
import 'package:hidayah/src/data/models/dailyQuotes/daily_quotes_response.dart';
import 'package:hidayah/src/data/models/delete_notes/delete_notes_request.dart';
import 'package:hidayah/src/data/models/dua/dua_category_response.dart';
import 'package:hidayah/src/data/models/dua_sub_category/dua_sub_category_response.dart';
import 'package:hidayah/src/data/models/new_notes/new_notes_request.dart';
import 'package:hidayah/src/data/models/notes/notes_request.dart';
import 'package:hidayah/src/data/models/prayerTimes/prayer_time_request.dart';
import 'package:hidayah/src/data/models/prayerTimes/prayer_time_response.dart';
import 'package:hidayah/src/data/models/quran_request.dart';
import 'package:hidayah/src/data/provider/auth_api_provider.dart';
import 'package:hidayah/src/data/provider/calendar_event_api_provider.dart';
import 'package:hidayah/src/data/provider/delete_notes_api_provider.dart';
import 'package:hidayah/src/data/provider/dua_category_api_provider.dart';
import 'package:hidayah/src/data/provider/dua_detailed_api_provider.dart';
import 'package:hidayah/src/data/provider/get_daily_quotes_provider.dart';
import 'package:hidayah/src/data/provider/get_daily_verses_provider.dart';
import 'package:hidayah/src/data/provider/get_prayer_times.dart';
import 'package:hidayah/src/data/provider/hadith_of_the_day_api_provider.dart';
import 'package:hidayah/src/data/provider/quran_request_provider.dart';
import 'package:hidayah/src/data/provider/youtube_videos_api_provider.dart';

import '../models/dua_detailed/dua_detailed_request.dart';
import '../models/dua_sub_category/dua_sub_category_request.dart';
import '../models/login/login_with_email_request.dart';
import '../models/personal_details/personal_details_request.dart';
import '../models/youtube_videos/youtube_videos_response.dart';
import '../provider/dua_sub_category_provider.dart';
import '../provider/insert_new_notes_api_provider.dart';
import '../provider/personal_details_api_provider.dart';
import '../provider/show_all_dua_api_provider.dart';
import '../provider/user_note_show_api_provider.dart';

class Repository{
  final quranRequestProvider  = QuranRequestProvider();
  final prayerTimesApiProvider = GetPrayerTimes();
  final dailyQuotesApiProvider = GetDailyQuotesProvider();
  final dailyVersesApiProvider = GetDailyVerses();
  final loginWithEmailApiProvider = AuthApiProvider();
  final duaCategoryApiProvider = DuaCategoryProvider();
  final duaSubCategoryApiProvider = DuaSubCategoryProvider();
  final duaDetailedApiProvider = DuaDetailedScreenApiProvider();
  final hadithOfTheDayApiProvider = HadithOfTheDayApiProvider();
  final personalDetailsApiProvider = PersonalDetailsApiProvider();
  final userNotesShowApiProvider = UserNotesShowApiProvider();
  final insertNewNotesApiProvider = InsertNewNotesApiProvider();
  final showAllDuaApiProvider = ShowAllDuaApiProvider();
  final youtubeVideosApiProvider = YoutubeVideosApiProvider();
  final calendarEventsApiProvider = CalendarEventApiProvider();
  final deleteNotesApiProvider = DeleteNotesApiProvider();


  /// test request provider

  Future<StateModel> quranFetchFiltered(QuranRequest request) =>
      quranRequestProvider.quranFetchFiltered(request);

  ///Prayer times
  Future<StateModel?> getAllPrayerTimes(GetPrayerTimesRequest request) =>
      prayerTimesApiProvider.fetchPrayerTimes(request);

  ///Daily quotes
  Future<StateModel?> getDailyQuotes() =>
    dailyQuotesApiProvider.getDailyQuotes();

  ///Daily verses
  Future<StateModel> fetchDailyVerses() =>
      dailyVersesApiProvider.fetchDailyVerses();
  
  ///Login with email
  Future<StateModel?> loginWithEmailAndPassword(LoginWithEmailRequest request) =>
      loginWithEmailApiProvider.loginWithEmailAndPassword(request);

  ///Dua Category
  Future<StateModel?> fetchDuaCategory() =>
      duaCategoryApiProvider.fetchDuaCategory();

  ///Dua sub category
  Future<StateModel?> fetchDuaSubCategory(DuaSubCategoryRequest request) =>
      duaSubCategoryApiProvider.fetchDuaSubCategory(request);

  ///Dua Detailed
  Future<StateModel?> fetchDuaDetailed(DuaDetailedRequest request) =>
      duaDetailedApiProvider.fetchDuaDetailed(request);

  ///Hadith of the day
  Future<StateModel?> fetchHadithOfTheDay() =>
      hadithOfTheDayApiProvider.fetchHadithOfTheDay();

  ///Personal Details
  Future<StateModel?>fetchPersonalDetails(PersonalDetailsRequest request) =>
      personalDetailsApiProvider.fetchPersonalDetails(request);

  ///Notes show
  Future<StateModel?>fetchUserNotes(NotesRequest request) =>
      userNotesShowApiProvider.fetchUserNotes(request);
  ///New notes
  Future<StateModel?>insertNewNotes(NewNotesRequest request) =>
      insertNewNotesApiProvider.insertNewNotes(request);

  Future<StateModel?>deleteNotes(DeleteNotesRequest request) =>
      deleteNotesApiProvider.deleteNotes(request);

  ///Youtube videos
  Future<StateModel?>fetchYouTubeVideos() =>
      youtubeVideosApiProvider.fetchYouTubeVideos();

  ///Calendar events
  Future<StateModel?>fetchCalendarEvents() =>
      calendarEventsApiProvider.fetchCalendarEvents();

}