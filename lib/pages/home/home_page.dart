import 'package:currency_converter/components/show_signout_modal.dart';
import 'package:currency_converter/model/common_state.dart';
import 'package:currency_converter/pages/home/components/currency_field.dart';
import 'package:currency_converter/pages/home/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/show_add_currency_modal.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomePageCubit? homePageCubit;

  setText(String text) async {
    double value = await double.parse(text.isNotEmpty ? text : "0.0");
    homePageCubit!.currencyList.forEach((e) async {
      double index = await double.parse(e!.value.toString());
      String result = text.isNotEmpty ? await (value * index).toString() : "";
      homePageCubit!.list[homePageCubit!.currencyList.indexOf(e)].text = result;
      homePageCubit!.cList[homePageCubit!.currencyList.indexOf(e)]
          .jumpTo(homePageCubit!.cList[homePageCubit!.currencyList.indexOf(e)].position.maxScrollExtent
          + homePageCubit!.cList[homePageCubit!.currencyList.indexOf(e)].position.extentAfter);
    });
  }

  @override
  void didChangeDependencies() {
    homePageCubit = BlocProvider.of(context)..getData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Convert"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => showSignOutModal(context),
          icon: Icon(Icons.account_circle_outlined),
        )
      ],
    ),
    body: BlocBuilder<HomePageCubit, CommonState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator(),);
        } else {
          return _buildContent(state);
        }
      },
    ),
  );

  Widget _buildContent(CommonState state) => SingleChildScrollView(
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        CurrencyField(
          prefix: homePageCubit!.responseModel!.query!.baseCurrency!,
          onChanged: setText,
        ),
        Column(
          children: homePageCubit!.currencyList.map((e) =>
              CurrencyField(
                prefix: e!.key,
                controller: homePageCubit!.list[homePageCubit!.currencyList.indexOf(e)],
                scrollController: homePageCubit!.cList[homePageCubit!.currencyList.indexOf(e)],
                readOnly: true,
              ),
          ).toList(),
        ),
        ElevatedButton(
          onPressed: () {
            if (homePageCubit!.currencyList.isNotEmpty) {
              showAddCurrencyModal(context, responseModel: homePageCubit!.responseModel!);
            } else {
              homePageCubit!.getData();
            }
          },
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text("Add currency",),
              SizedBox(width: 10,),
              Icon(Icons.add)
            ],
          ),
        ),
      ],
    ),
  );
}