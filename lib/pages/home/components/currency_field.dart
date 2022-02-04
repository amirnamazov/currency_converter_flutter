import 'package:flutter/material.dart';

class CurrencyField extends StatefulWidget {

  CurrencyField({
    required this.prefix,
    this.controller,
    this.scrollController,
    this.onChanged,
    this.removeField,
    this.replaceField,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final ScrollController? scrollController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? removeField;
  final ValueChanged<String>? replaceField;
  final bool readOnly;
  final String prefix;

  @override
  _CurrencyFieldState createState() => _CurrencyFieldState();
}

class _CurrencyFieldState extends State<CurrencyField> {

  @override
  Widget build(BuildContext context) => Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.readOnly ? Colors.transparent : Colors.lightBlueAccent,
            )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => widget.replaceField!.call(widget.prefix),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 10,),
                  Text(widget.prefix),
                  Icon(Icons.keyboard_arrow_down_outlined)
                ],
              ),
            ),
            Expanded(
              child: TextField(
                controller: widget.controller,
                scrollController: widget.scrollController,
                // focusNode: widget.focusNode,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                scrollPadding: EdgeInsets.zero,
                scrollPhysics: ClampingScrollPhysics(),
                readOnly: widget.readOnly,
                textAlign: TextAlign.end,
                maxLength: 15,
                onChanged: (text) => widget.onChanged!.call(text),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  counterText: "",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.readOnly ? IconButton(
                  onPressed: () {
                    if (widget.readOnly) widget.removeField!.call(widget.prefix);
                  },
                  icon: Icon(Icons.delete_outlined),
                  padding: EdgeInsets.zero,
                  splashRadius: 24,
                ) : SizedBox(width: IconTheme.of(context).size,),
                SizedBox(width: widget.readOnly ? 0 : 10,),
              ],
            ),
          ],
        ),
      )
  );
}