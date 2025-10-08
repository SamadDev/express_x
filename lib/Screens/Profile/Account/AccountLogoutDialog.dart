import 'package:x_express/Utils/exports.dart';

// ignore_for_file: must_be_immutable
class AccountLogoutDialog extends StatelessWidget {
  const AccountLogoutDialog({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 306,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      decoration:  BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: "assets/images/activity.png",
                  height: 24,
                  width: 24,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: GlobalText(text:"Are you sure to sign out?", textAlign: TextAlign.left,fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,fontSize: 15,color: AppTheme.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 39),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                left: 42,
                right: 11,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    height: 36,
                    width: 100,
                    text: "cancel",
                  
                    buttonTextStyle: TextStyle(fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,fontSize: 17,color: AppTheme.black),
                  ),
                  CustomElevatedButton(
                    height: 36,
                    width: 100,
                    text: "log out",
                    margin: EdgeInsets.only(left: 21),
                    buttonTextStyle: TextStyle(fontFamily: 'nrt-reg',fontWeight: FontWeight.w500,fontSize: 16,color: AppTheme.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class CustomElevatedButton extends BaseButton {
  CustomElevatedButton({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    EdgeInsets? margin,
    VoidCallback? onPressed,
    ButtonStyle? buttonStyle,
    Alignment? alignment,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    double? height,
    double? width,
    required String text,
  }) : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          width: width,
          alignment: alignment,
          margin: margin,
        );

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: this.height ?? 47,
        width: this.width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                text,
                style: buttonTextStyle ??
                    TextStyle(fontFamily: 'nrt-reg',fontWeight: FontWeight.w500),
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}


class BaseButton extends StatelessWidget {
  BaseButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.buttonStyle,
    this.buttonTextStyle,
    this.isDisabled,
    this.height,
    this.width,
    this.margin,
    this.alignment,
  }) : super(
          key: key,
        );

  final String text;

  final VoidCallback? onPressed;

  final ButtonStyle? buttonStyle;

  final TextStyle? buttonTextStyle;

  final bool? isDisabled;

  final double? height;

  final double? width;

  final EdgeInsets? margin;

  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
