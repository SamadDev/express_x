import 'package:x_express/Utils/exports.dart';
class DirectionalityWidget extends StatelessWidget {
  final child;
  const DirectionalityWidget({Key? key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language=Provider.of<Language>(context,listen: false);
    return Directionality(textDirection: language.getWords=='en'?TextDirection.ltr:TextDirection.rtl, child: child);
  }
}
