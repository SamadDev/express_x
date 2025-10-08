import 'package:photo_view/photo_view.dart';
import 'package:x_express/Utils/exports.dart';

class ImageShow extends StatelessWidget {
  final uuId;
  ImageShow({this.uuId});

  Widget build(BuildContext context) {
    final getImageById = Provider.of<UserFormService>(context, listen: false).getImagesByUuId(uuId);

    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: AppTheme.white,
        appBar: AppBar(
          backgroundColor: AppTheme.transparent,
          iconTheme: IconThemeData(color: AppTheme.primary),
        ),
        body: FutureBuilder(
            future: getImageById,
            builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator(color: AppTheme.primary))
                : PhotoView(
                    imageProvider: NetworkImage("url"),
                  )));
  }
}
