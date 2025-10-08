import "package:x_express/Utils/exports.dart";
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PdfViewerScreen extends StatelessWidget {
  final id;
  final type;
  final url;
  final fromDate;
  final toDate;
  final currencyId;
  const PdfViewerScreen({Key? key, this.id, this.type, this.url, this.fromDate, this.toDate,this.currencyId="0"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    print(type == "activity"
        ?"url is--: "+ "https://api.kalcompany.net/api/reports/?reportName=reports/customer-statement&parameters=FromDate=$fromDate,ToDate=$toDate,AccountId=3115&format=html&inline=true&fileName=customer-statement".replaceAll("", "")
        : "$domain" +
            "reports/?reportName=reports/$url&parameters=Id=$id&format=html&inline=true&fileName=exported-file");
    return Scaffold(
      appBar: AppBar(title: Text(language["document"]), actions: [
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            Share.share(

                ///api/reports/?reportName=reports/customer-statement&parameters=FromDate=@FromDate,ToDate=@ToDate,CurrencyId=@CurrencyId,UserId=@UserId&format=html&inline=true&fileName=customer-statement
                type == "activity"
                    ? "$domain" +
                        "reports/?reportName=reports/customer-statement&parameters=FromDate=$fromDate,ToDate=$toDate,CurrencyId=$currencyId,UserId=${Auth.customer_id},AccountId=0&format=html&inline=true&fileName=customer-statement"
                    : "$domain" +
                        "reports/?reportName=reports/$url&parameters=Id=$id&format=html&inline=true&fileName=exported-file",
                subject: 'Document');
          },
        )
      ]),
      body: InAppWebView(
          initialUrlRequest: URLRequest(
              url: WebUri(type == "activity"
                  ? "$domain" +
                      "reports/?reportName=reports/customer-statement&parameters=FromDate=$fromDate,ToDate=$toDate,CurrencyId=$currencyId,UserId=${Auth.customer_id},AccountId=0&format=html&inline=true&fileName=customer-statement"
                  : "$domain" +
                      "reports/?reportName=reports/$url&parameters=Id=$id&format=html&inline=true&fileName=exported-file"))),
    );
  }
}
