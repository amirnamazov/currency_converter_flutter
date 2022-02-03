import 'dart:convert';
import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/model/response.dart';
import 'package:currency_converter/services/request.dart';
import 'package:currency_converter/services/request_api.dart';
import 'package:currency_converter/utils/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<CommonState> {
  HomePageCubit() : super(LoadingState());

  ResponseModel? responseModel;
  List<MapEntry<String, dynamic>?> currencyList = [];
  List<TextEditingController> list = [];
  List<ScrollController> cList = [];

  getData() {
    InternetConnection.check().then((value) {
      if (value) {
        _fetchData();
      } else {
        emit(InternetErrorState());
      }
    });
  }

  void _fetchData() {
    emit(LoadingState());
    RequestClient().get(
      endPoint: RequestApi.latest,
      onSuccess: (code, response) {
        responseModel = ResponseModel.fromJson(json.decode(response!));
        currencyList = responseModel!.data!.entries.toList();
        list.clear();
        cList.clear();
        currencyList.forEach((element) {
          list.add(TextEditingController());
          cList.add(ScrollController());
        });
        emit(ContentState());
      },
      onFailure: (code, response) {
        emit(ErrorState());
      },
      onError: () {
        emit(ErrorState());
      },
    );
  }
}