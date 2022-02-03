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
  String? _baseCurrency;

  getData({String base_currency = 'USD', bool replaced = false}) {
    InternetConnection.check().then((value) {
      if (value) {
        _fetchData(base_currency, replaced);
      } else {
        emit(InternetErrorState());
      }
    });
  }

  void _fetchData(String base_currency, bool replaced) {
    emit(LoadingState());
    RequestClient().get(
      endPoint: RequestApi.latest,
      queryParam: {"base_currency" : base_currency},
      onSuccess: (code, response) {
        responseModel = ResponseModel.fromJson(json.decode(response!));
        if (replaced) {
          List<MapEntry<String, dynamic>?> allList = responseModel!.data!.entries.toList();
          for (int i = 0; i < currencyList.length; i++) {
            if (currencyList[i]!.key != base_currency)
              currencyList[i] = allList[allList.indexWhere((e) => e!.key == currencyList[i]!.key)];
            else
              currencyList[i] = allList[allList.indexWhere((e) => e!.key == _baseCurrency)];
          }
          emit(ContentState());
        }
        else addCurrency('EUR');
      },
      onFailure: (code, response) {
        emit(ErrorState());
      },
      onError: () {
        emit(ErrorState());
      },
    );
  }

  void addCurrency(String prefix) {
    List<MapEntry<String, dynamic>?> allList = responseModel!.data!.entries.toList();
    currencyList.add(allList[allList.indexWhere((element) => element!.key == prefix)]);
    _updateControllers();
  }

  void removeCurrency(String prefix) {
    currencyList.removeAt(currencyList.indexWhere((element) => element!.key == prefix));
    _updateControllers();
  }

  void replaceCurrency(String initialPrefix, String finalPrefix) {
    if (initialPrefix == responseModel!.query!.baseCurrency) {
      _baseCurrency = responseModel!.query!.baseCurrency;
      getData(base_currency: finalPrefix, replaced: true);
    } else {
      List<MapEntry<String, dynamic>?> allList = responseModel!.data!.entries.toList();
      currencyList[currencyList.indexWhere((element) => element!.key == initialPrefix)]
      = allList[allList.indexWhere((element) => element!.key == finalPrefix)];
      emit(ContentState());
    }
  }

  void _updateControllers() {
    list.clear();
    cList.clear();
    currencyList.forEach((element) {
      list.add(TextEditingController());
      cList.add(ScrollController());
    });
    emit(ContentState());
  }
}