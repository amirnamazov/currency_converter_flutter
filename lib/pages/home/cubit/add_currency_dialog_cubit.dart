import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/model/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCurrencyDialogCubit extends Cubit<CommonState> {
  AddCurrencyDialogCubit() : super(ContentState());

  List<MapEntry<String, dynamic>?> currencyList = [];

  setCurrencyList(ResponseModel responseModel, String text) {
    currencyList.clear();
    responseModel.data!.entries.forEach((e) {
      if (e.key.startsWith(text.trim().toUpperCase())) {
        currencyList.add(e);
      }
    });
    emit(ContentState());
  }
}