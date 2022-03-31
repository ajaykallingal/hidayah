import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/src/data/models/quran_request.dart';

import '../../constants/urls.dart';

class ApiClient{
  ApiClient(){
    initClient();
  }
late Dio dio;
  late BaseOptions _baseOptions;


  initClient()async{
    _baseOptions = BaseOptions(
      baseUrl: Urls.QuranUrl,
      connectTimeout: 30000,
      receiveTimeout: 1000000,
      followRedirects: true,
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
  Future<Response>getPrayerTimes(){
    return dio.get(Urls.GetPrayerTimes);
  }





}