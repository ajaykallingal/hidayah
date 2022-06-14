import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:hidayah/src/data/models/calendar_add_events/calendar_add_events_request.dart';
import 'package:hidayah/src/data/models/calendar_delete_events/calendar_delete_event_request.dart';
import 'package:hidayah/src/data/models/delete_notes/delete_notes_request.dart';
import 'package:hidayah/src/data/models/dua_detailed/dua_detailed_request.dart';
import 'package:hidayah/src/data/models/dua_sub_category/dua_sub_category_request.dart';
import 'package:hidayah/src/data/models/login/login_with_email_request.dart';
import 'package:hidayah/src/data/models/new_notes/new_notes_request.dart';
import 'package:hidayah/src/data/models/notes/notes_request.dart';
import 'package:hidayah/src/data/models/personal_details/personal_details_request.dart';
import 'package:hidayah/src/data/models/prayerTimes/prayer_time_request.dart';
import 'package:hidayah/src/data/models/quran_request.dart';

import '../../constants/urls.dart';
import '../../shared_pref/object_factory.dart';
import '../models/registration/registration_request.dart';
import '../models/show_all_dua/show_all_dua_request.dart';

class ApiClient{
  ApiClient(){
    initClient();
  }
late Dio dio;
  late BaseOptions _baseOptions;


  initClient()async{
    _baseOptions = BaseOptions(
      baseUrl: Urls.baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 1000000,
      followRedirects: true,
      // validateStatus: (status)=> true,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        // "authorization": basicAuth
      },
      responseType: ResponseType.json,
        receiveDataWhenStatusError: true);

      dio = Dio(_baseOptions);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (client) {
      client.badCertificateCallback =
      (X509Certificate cert,String host, int port){
        return true;

      };
      return null;
    } ;
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (requestOptions,handler){
          return handler.next(requestOptions);
        },
        onError: (DioError dioError, handler){
          return handler.next(dioError);
      },

      ));

      // dio.interceptors.add(
      //   RetryOnConnectionChangeInterceptor(
      //     requestRetrier =
      //   ),
      // );


  }

  ///quran screen

  Future<Response> quranFetchFiltered(QuranRequest request){
    return dio.post(Urls.QuranUrl,data: request);
  }

  ///prayer times
  Future<Response> fetchPrayerTimes(GetPrayerTimesRequest request){
    return dio.post(Urls.GetPrayerTimes,data: request);
  }
  ///Daily quotes
  Future<Response> fetchDailyQuotes(){
    return dio.get(Urls.GetDailyQuotes);
  }
  ///Daily verses
  Future<Response> fetchDailyVerses(){
    return dio.get(Urls.GetDailyVerses);
  }
  ///Login with email
  Future<Response> loginWithEmailAndPassword(LoginWithEmailRequest request){
return dio.post(Urls.LoginWithEmail,data: request);
  }

  ///Registration of new user
  Future<Response> registrationOfNewUser(RegistrationRequest request){
    return dio.post(Urls.RegistrationOfNewUser,data: request);
  }
  ///Dua categories
  Future<Response> fetchDuaCategory(){
    return dio.get(Urls.GetDuaCategory);
  }

  ///Dua Sub Category
  Future<Response> fetchDuaSubCategory(DuaSubCategoryRequest request){
    return dio.post(Urls.GetDuaSubCategory,data: request);
  }

  ///Dua Detailed Screen
  Future<Response> fetchDuaDetailed(DuaDetailedRequest request){
    return dio.post(Urls.GetDuaDetailed,data: request);
  }

  ///Show All dua
  Future<Response> showAllDua(ShowAllDuaRequest request){
    return dio.post(Urls.ShowAllDua,data: request);
  }
  ///Hadith of the day
  Future<Response> fetchHadithOfTheDay(){
    return dio.get(Urls.GetHadith);
  }

  ///Personal details
  Future<Response> fetchPersonalDetails(PersonalDetailsRequest request){
    return dio.post(Urls.PersonalDetails,data: request);
  }

  ///Notes show
  Future<Response> fetchUserNotes(NotesRequest request){
    return dio.post(Urls.FetchUserNotes,data: request);
  }

  ///New notes
  Future<Response> insertNewNotes(NewNotesRequest request){
    return dio.post(Urls.InsertNewNotes,data: request);
  }

  ///delete notes
  Future<Response> deleteNotes(DeleteNotesRequest request){
    return dio.post(Urls.DeleteNotes,data: request);
  }
  ///Youtube videos
  Future<Response> fetchYouTubeVideos(){
    return dio.get(Urls.YoutubeVideo);
  }

  ///Calendar events
  Future<Response> fetchCalendarEvents(){
    return dio.get(Urls.CalendarEvents + ObjectFactory().prefs.getUserId().toString());
  }

  ///Calendar add events
  Future<Response> fetchCalendarAddEvent(CalendarAddEventRequest request){
    return dio.post(Urls.CalendarAddEvents,data: request);
  }


  ///Calendar delete events
  Future<Response> calendarDeleteEvent(CalendarDeleteEventRequest request){
    return dio.delete(Urls.CalendarDeleteEvents,data: request);
  }



}