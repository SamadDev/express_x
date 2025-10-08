import 'package:x_express/Utils/exports.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langauge=Provider.of<Language>(context,listen: false).getWords;
    return Scaffold(
        appBar: AppBar(title: Text("Leaders"),),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.only(left: 1),
                  child:GlobalText(text:
                    langauge["about"],
                    fontSize: 22, fontFamily: 'nrt-bold',fontWeight: FontWeight.bold, color: AppTheme.black,
                  )),
              SizedBox(height: 23),
              Container(
                  width: 353,
                  margin: EdgeInsets.only(right: 6),
                  child: GlobalText(text:
                      "Our Company General Trading and International Transportation Company We will make everything easier for you in the fastest way and with experienced staff, our special teams are always ready to receive your orders as soon as possible. Whether your goods are commercial or industrial, we will transport them legally and safely. Make sure to check your goods with us. A competent staff will monitor the transportation of your goods. Therefore, entrust us with the task of managing the transportation of your goods in China.",
                      fontFamily: 'nrt-reg', fontSize: 16, color: AppTheme.black.withOpacity(0.8))
                  // child: AppTheme.text(
                  //   font: 'nrt-reg',
                  //   size: 16,
                  //   color: AppTheme.black.withOpacity(0.8),
                  //   text:
                  //       "Nulla sapiente nihil voluptas voluptas omnis. Et sint magnam molestiae qui quia. Nulla sit ullam et in libero sapiente aut. Exercitationem ipsam quam. Similique consectetur necessitatibus harum.\n \rRepellendus commodi veritatis. Impedit iste itaque nisi omnis nulla incidunt voluptates tenetur. Et exercitationem nam quis nisi eos et et rerum.\n Porro ut minima sit dolorem dolores tempora autem mollitia. Ducimus voluptate sed quasi culpa. Delectus tempora ut ab aut explicabo harum rerum ipsum unde. Voluptas vel et porro corrupti eum et nulla dolor numquam. Quam vero voluptatem eos a quo sunt possimus minima. Aut dicta ipsum dolor et aliquid nobis sed voluptatem.",
                  // ),
                  ),
              SizedBox(height: 5)
            ])));
  }
}
