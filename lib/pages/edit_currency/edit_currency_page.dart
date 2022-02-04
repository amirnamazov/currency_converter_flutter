import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/model/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/edit_currency_cubit.dart';

class EditCurrencyPage extends StatefulWidget {

  EditCurrencyPage({this.responseModel,
    this.addCurrency,
    this.replaceCurrency});

  final ResponseModel? responseModel;
  final ValueChanged<String>? addCurrency;
  final ValueChanged<String>? replaceCurrency;

  @override
  _EditCurrencyPageState createState() => _EditCurrencyPageState();
}

class _EditCurrencyPageState extends State<EditCurrencyPage> {

  EditCurrencyCubit? editCurrencyCubit;

  @override
  void didChangeDependencies() {
    editCurrencyCubit = BlocProvider.of(context)..setCurrencyList(widget.responseModel!, "");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Edit Currency"),
      centerTitle: true,
      bottom: PreferredSize(
          child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 15,),
                  Text("Base currency: ",),
                  Text(widget.responseModel!.query!.baseCurrency!,
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: TextField(
                      scrollPhysics: ClampingScrollPhysics(),
                      textAlign: TextAlign.end,
                      maxLength: 5,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (t) => editCurrencyCubit!.setCurrencyList(widget.responseModel!, t),
                      // onTap: () => searchTapped = true,
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
          preferredSize: Size.fromHeight(50)
      ),
    ),
    body: BlocBuilder<EditCurrencyCubit, CommonState>(
      builder: (context, state) {
        return ListView(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            children: editCurrencyCubit!.currencyList.map((e) {
              return InkWell(
                onTap: () {
                  if (widget.addCurrency != null) widget.addCurrency!.call(e!.key);
                  else if (widget.replaceCurrency != null) widget.replaceCurrency!.call(e!.key);
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
        );
      },
    ),
  );
}