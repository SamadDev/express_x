import 'package:x_express/Utils/exports.dart';

void ButtonSheetWidget({context, child, heightFactor}) {
  showModalBottomSheet(
    backgroundColor: AppTheme.grey_thick,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(13), topRight: Radius.circular(13))),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: heightFactor,
        child: child,
      );
    },
  );
}
