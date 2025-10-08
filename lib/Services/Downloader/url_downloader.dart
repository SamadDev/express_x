import 'package:x_express/Utils/exports.dart';
import 'package:http/http.dart' as http;

class DownloadService extends ChangeNotifier {
  bool isLoading = false;
  var filePath;
  Future<void> shareFile(url,orderNumber) async {
    try {
      isLoading = true;
      notifyListeners();
      print("start isLoading is: $isLoading");
      final bytes = await http.get(Uri.parse(url)).then((response) => response.bodyBytes);
      final temp = await getTemporaryDirectory();
      final file = File('${temp.path}/$orderNumber.pdf');
      await file.writeAsBytes(bytes);
      notifyListeners();
      isLoading = false;
      await Share.shareXFiles([XFile(file.path)], text: 'Document');
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print("isLoading is: $isLoading");
      print("error download file is: $e");
    }
  }
}