import 'package:x_express/Utils/exports.dart';
import 'package:lottie/lottie.dart';


class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final language=Provider.of<Language>(context,listen:false);
    return Scaffold(
      backgroundColor: AppTheme.scaffold,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lotties/empty.json',
            width: 250,
            height: 250,
          ),
          GlobalText(text:
            language.getWords['there_is_no_order_at_that_time'],color:AppTheme.black,
          )
        ],
      )),
    );
  }
}
