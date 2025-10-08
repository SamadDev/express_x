import 'package:x_express/Utils/exports.dart';

class TextFormFieldWidget extends StatelessWidget {
  final controller;
  final obscureText;
  final hintText;
  final buttonPrefix;
  final buttonPostfix;
  final textInputAction;
  final textInputType;
  final formValidator;
  final inputFormatters;
  final onEditingComplte;

  TextFormFieldWidget({
    this.hintText,
    this.controller,
    this.textInputAction,
    this.textInputType,
    this.obscureText = false,
    this.buttonPostfix,
    this.buttonPrefix,
    this.formValidator,
    this.inputFormatters,
    this.onEditingComplte,
  });

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 10, left: 10),
        margin: EdgeInsets.only(top: 10),
        height: 70,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: AppTheme.card),
        child: Row(
          children: [
            buttonPrefix ?? SizedBox(),
            Expanded(
              child: TextFormField(
                onEditingComplete: onEditingComplte,
                inputFormatters: inputFormatters,
                controller: controller,
                validator: formValidator,
                textInputAction: textInputAction,
                keyboardType: textInputType,
                style: TextStyle(

                  color: AppTheme.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                maxLines: 1,
                obscureText: obscureText,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: AppTheme.grey,
                    fontFamily: 'nrt-bold',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            buttonPostfix ?? SizedBox(),
          ],
        ));
  }
}
