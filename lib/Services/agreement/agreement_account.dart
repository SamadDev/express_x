import 'package:x_express/Modules/agreement/agreement.dart';
import 'package:x_express/Utils/exports.dart';

class AgreementService with ChangeNotifier {
  AccountCustomerInfo? accountCustomerData;
  var singAttachmentData;
  String pdfUrl = '';
  bool isLoading = false;
  bool isAssignmentAgreement = false;

  Future<void> getSingAttachment({context}) async {
    final language = Provider.of<Language>(context, listen: false);
    final accountInfo = Provider.of<DashboardService>(context, listen: false);
    accountCustomerData = await accountInfo.getAccountInfo();
    print("account customer info is: $accountCustomerData");
    try {
      var data = await Request.reqGet('shared/attachments/${accountCustomerData!.uniqueId}/1');

      if (data != null) {
        pdfUrl = "${dotenv.env["AGREEMENTDOMAIN"]}${data["fileUrl"]}/${data['uniqueName']}";
        isAssignmentAgreement = true;
      } else {
        pdfUrl = "$domain" +
            "reports/?reportName=reports/${language.languageCode == "kr" ? "customer-contract-kr" : "customer-contract-ar"}&parameters=Id=${accountCustomerData!.id}&format=pdf&inline=true&fileName=voucher";
      }
    } catch (e) {
      pdfUrl = "$domain" +
          "reports/?reportName=reports/${language.languageCode == "kr" ? "customer-contract-kr" : "customer-contract-ar"}&parameters=Id=${accountCustomerData!.id}&format=pdf&inline=true&fileName=voucher";
    }
    notifyListeners();
  }

  bool isUploadLoading = false;

  void uploadAttachment({uniqueId, imageFile, code, context}) async {
    Dio dio = Dio();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    isUploadLoading = true;
    notifyListeners();
    print("first $isUploadLoading");
    if (result != null && result.files.isNotEmpty) {
      String? filePath = result.files.single.path;

      String fileName = File(filePath!).path.split('/').last;

      FormData formData = FormData.fromMap({
        "attachment": json.encode({
          "attachmentTypeId": "1",
          "dateTime ": DateTime.now().toString(),
          "fileUrl": "customers/${code}",
          "refId": uniqueId,
        }),
        'file': await MultipartFile.fromFile(File(filePath).path, filename: fileName),
      });
      try {
        Response response = await dio.post(
          '$domain' + 'shared/attachments',
          options: Options(headers: {"Authorization": "Bearer ${Auth.token}", "userType": "mobile", "language": "en"}),
          data: formData,
        );

        print(response.statusCode);
        if (response.statusCode == 200) {
          await getSingAttachment(context: context);
          isUploadLoading = false;
          print("first $isUploadLoading");
          notifyListeners();
        } else {
          print('Failed to upload attachment');
        }
        await getSingAttachment();
        notifyListeners();
      } catch (e) {
        isUploadLoading = false;
        print("first $isUploadLoading");
        notifyListeners();
        print('Error uploading attachment: $e');
      }
    }
  }
}
