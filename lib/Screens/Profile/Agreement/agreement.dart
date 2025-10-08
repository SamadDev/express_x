import 'package:x_express/Services/Downloader/url_downloader.dart';
import 'package:x_express/Services/agreement/agreement_account.dart';
import "package:x_express/Utils/exports.dart";
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    final agreement = Provider.of<AgreementService>(context, listen: false);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Consumer<AgreementService>(builder: (context, data, _) {
          return data.isAssignmentAgreement
              ? SizedBox.shrink()
              : FloatingActionButton.extended(
                  backgroundColor: AppTheme.primary,
                  onPressed: () async {
                    agreement.uploadAttachment(
                        imageFile: "",
                        uniqueId: agreement.accountCustomerData!.uniqueId!,
                        context: context,
                        code: agreement.accountCustomerData!.code);
                  },
                  icon: Icon(
                    Icons.upload,
                    color: AppTheme.white,
                    size: 19,
                  ),
                  label: GlobalText(
                    text: language.getWords['upload'],
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                );
        }),
        appBar: AppBar(title: GlobalText(text: language.getWords["agreement"]), actions: [
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
                      shareFile.shareFile(agreement.pdfUrl, DateTime.now().toString());
                    },
                  ),
          )
        ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: agreement.getSingAttachment(context: context),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: AppTheme.primary));
                } else
                  return Consumer<AgreementService>(
                    builder: (ctx, agreement, _) => agreement.isUploadLoading
                        ? Center(child: CircularProgressIndicator(color: AppTheme.primary))
                        : SfPdfViewerTheme(
                            data: SfPdfViewerThemeData(
                                progressBarColor: AppTheme.primary, backgroundColor: Colors.white10),
                            child: SfPdfViewer.network(agreement.pdfUrl)),
                  );
              }),
        ));
  }
}
