import 'package:x_express/Screens/UserForm/Receive/Widgets/receive_client_card.dart';
import 'package:x_express/Services/UsrForm/Receive/revceive_list.dart';
import 'package:x_express/Utils/exports.dart';
class ReceiveSearchListScreen extends StatelessWidget {
  final text;
  ReceiveSearchListScreen({this.text});
  Widget build(BuildContext context) {
    return Consumer<ReceiveServices>(
      builder: (ctx, data, _) =>
      data.receiveSearchList.isEmpty
          ? EmptyScreen()
          : Stack(
            children: [

              LazyLoadScrollView(
                onEndOfPage: () async {
                  data.changeState();
                  await data.getReceivesSearch(isPagination: true, text: text);
                  data.changeState();
                },
                child: AnimationLimiter(
                        child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 0, top: 7),
                itemCount: data.receiveSearchList.length,
                itemBuilder: (ctx, i) => AnimationConfiguration.staggeredList(
                  position: i,
                  duration: Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 70.0,
                    child: FadeInAnimation(
                      child: Column(
                        children: [
                          OrderClientReceiveCard(
                            type: "user",
                            orderReceive: data.receiveSearchList[i],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                        ),
                      ),
              ),
              Visibility(
                visible: data.isLoading,
                child: Positioned(
                  bottom: 5,
                  right: 10,
                  left: 10,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              )
            ],
          ) ,
    );
  }
}
