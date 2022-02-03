import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/model/response.dart';
import 'package:currency_converter/pages/home/cubit/add_currency_dialog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

void showAddCurrencyModal(BuildContext context, {ResponseModel? responseModel}) {

  AddCurrencyDialogCubit? cubit;
  bool searchTapped = false;

  showSlidingBottomSheet(
      context,
      builder: (context) {
        return SlidingSheetDialog(
          cornerRadius: 20,
          margin: EdgeInsets.only(top: 50),
          snapSpec: SnapSpec(
            snap: true,
            snappings: [1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          headerBuilder: (c, sh) => Material(
            child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 15,),
                    Text("Base currency: ",),
                    Text(responseModel!.query!.baseCurrency!,
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: TextField(
                        scrollPhysics: ClampingScrollPhysics(),
                        textAlign: TextAlign.end,
                        maxLength: 5,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (t) => cubit!.setCurrencyList(responseModel, t),
                        onTap: () => searchTapped = true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          counterText: "",
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
          customBuilder: (cc, s, sh) => BlocProvider(
            create: (context) {
              return AddCurrencyDialogCubit();
            },
            child: Builder(
              builder: (c) {
                if (!searchTapped) cubit = BlocProvider.of(c)..setCurrencyList(responseModel!, "");
                return BlocBuilder<AddCurrencyDialogCubit, CommonState>(
                  builder: (context, state) {
                    return Material(
                        child: ListView(
                            controller: s,
                            physics: ClampingScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            children: cubit!.currencyList.map((e) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Column(
                                  children: [
                                    SizedBox(height: 15,),
                                    Row(
                                      children: [
                                        SizedBox(width: 5,),
                                        Text(e!.key),
                                        Spacer(),
                                        Text(e.value.toString()),
                                        SizedBox(width: 5,),
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: Colors.black26,
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                        )
                    );
                  },
                );
              },
            )
          ),
        );
      }
  );
}