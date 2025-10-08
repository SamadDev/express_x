import 'package:x_express/Services/Downloader/url_downloader.dart';
import 'package:x_express/Services/webviews/webview_url.dart';
import "package:x_express/Utils/exports.dart";
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PdfViewerScreen extends StatefulWidget {
  final id;
  final type;
  final url;
  final branchId;
  final fromDate;
  final toDate;
  final currencyId;
  final fileExtension;
  final codeId;
  const PdfViewerScreen({
    Key? key,
    this.id,
    this.type,
    this.url,
    this.branchId,
    this.fromDate,
    this.toDate,
    this.codeId = "",
    this.currencyId = "0",
    required this.fileExtension,
  }) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String customerId = '';
  void fetchAccountInfo() async {
    final getAccountInfo = Provider.of<DashboardService>(context, listen: false);
    final data = await getAccountInfo.getAccountInfo();
    print("cuseromr data is:${data!.id!.toString()} $data");
    setState(() {
      customerId = data!.id.toString();
    });
  }

  @override
  void didChangeDependencies() {
    fetchAccountInfo();
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    print("customer id is: ${widget.type}");
    print("customer id is: ${customerId}");
    String pdfUrl = widget.type == "activity"
        ? "${domain}reports/?reportName=reports/customer-statement&parameters=FromDate=${widget.fromDate},ToDate=${widget.toDate},CurrencyId=${widget.currencyId},UserId=${Auth.customer_id},AccountId=0&format=html&inline=true&fileName=customer-statement"
        : widget.type == "branch"
            ? "${domain}reports/?reportName=reports/contact-us&parameters=Id=$customerId,CodeId=${widget.codeId},BranchId=${widget.branchId}&format=pdf&inline=true&fileName=exported-file"
            : "${domain}reports/?reportName=reports/${widget.url}&parameters=Id=${widget.id}&format=pdf&inline=true&fileName=exported-file";
    print(pdfUrl);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      appBar: AppBar(title: Text(language["document"]), actions: [
        Consumer<DownloadService>(
          builder: (ctx, shareFile, _) => shareFile.isLoading
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                    child: SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(color: AppTheme.primary, strokeWidth: 2)),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async {
                    shareFile.shareFile(pdfUrl, widget.fileExtension);
                  },
                ),
        )
      ]),
      body: Consumer<WebviewService>(
        builder: (ctx, webviewService, _) => Stack(
          children: [
            InAppWebView(
              onLoadStart: (controller, url) {
                webviewService.onStartLoading();
              },
              onLoadStop: (controller, url) {
                webviewService.onEndLoading();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  webviewService.onEndLoading();
                }
              },
              initialUrlRequest: URLRequest(url: WebUri(pdfUrl)),
            ),
            if (webviewService.isLoading)
              Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: AppTheme.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
