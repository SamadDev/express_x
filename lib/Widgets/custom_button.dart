import 'package:x_express/Utils/exports.dart';

class Customer_Button extends StatelessWidget {
  final text;
  final onPress;
  final color;
  final textColor;
  final fontSize;
  final String icon;
  const Customer_Button({
    this.text,
    this.onPress,
    this.color = AppTheme.primary,
    this.textColor = AppTheme.secondary,
    this.fontSize = 20.0,
    this.icon = '',
  });

  @override
  Widget build(BuildContext context) {
    print(icon);
    return SizedBox(
      height: 47,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              fixedSize: Size(336, 47),
              backgroundColor: color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          onPressed: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon.isEmpty
                  ? SizedBox.shrink()
                  : Image.asset("assets/images/$icon", width: 25, height: 25, color: AppTheme.white),
              SizedBox(
                width: 8,
              ),
              GlobalText(
                text: text,
                color: textColor,
                fontSize: fontSize,
              ),
            ],
          )),
    );
  }
}
