import 'package:x_express/Screens/Receives/receive_list.dart';
import 'package:x_express/Screens/Receives/recieve_search.dart';
import 'package:x_express/Screens/UserForm/Receive/Filter/receive_filter.dart';
import 'package:x_express/Services/UsrForm/Receive/receive_status.dart';
import 'package:x_express/Utils/exports.dart';


class ReceiveTapBar extends StatefulWidget {
  final int page;
  ReceiveTapBar({this.page = 0});
  State<ReceiveTapBar> createState() => _ReceiveTapBarState();
}

class _ReceiveTapBarState extends State<ReceiveTapBar> with SingleTickerProviderStateMixin {
  TabController? _controller;
  TextEditingController _searchController = TextEditingController();

  Widget build(BuildContext context) {
    final Debouncer _debouncer = Debouncer(milliseconds: 200);

    final language = Provider.of<Language>(context, listen: false);
    final status = Provider.of<ReceiveStatusService>(context, listen: false);
    return FutureBuilder(
      future: status.getStatusReceive(),
      builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
          ? ShimmerTab(title: language.getWords['receives'])
          : DefaultTabController(
              length: status.receiveStatus.length,
              initialIndex: 0,
              child: Scaffold(
                appBar: AppBar(
                  actions: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(createRoute(ReceiveFilterScreen(
                          type: "user",
                        )));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 20, left: 20.0, top: 15),
                        child: Image.asset(
                          'assets/images/filter.png',
                          width: 20,
                          height: 20,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ],
                  backgroundColor: AppTheme.scaffold,
                  centerTitle: false,
                  toolbarHeight: 70.0,
                  titleSpacing: 20,
                  title: Text(
                    language.getWords['receives'],
                  ),
                ),
                body: Consumer<ReceiveServices>(
                  builder: (ctx, receive, _) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 12, left: 12, bottom: 12),
                        child: CustomSearchFormField(
                          controller: _searchController,
                          prefix: Icon(Icons.search,size: 24),
                          hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: AppTheme.black),
                          hintText: language.getWords['search'],
                          fillColor: AppTheme.white,
                          borderType: true,
                          textInputAction: TextInputAction.search,
                          onChange: (value) {
                            _debouncer.run(() {
                              receive.getReceivesSearch(text: value, isRefresh: true);
                            });
                          },
                        ),
                      ),
                      if (_searchController.text.isEmpty) ...[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TabBar(
                            controller: _controller,
                            indicator: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: AppTheme.primary),
                            labelColor: AppTheme.white,
                            labelPadding: EdgeInsets.zero,
                            unselectedLabelColor: AppTheme.black,
                            isScrollable: false,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: List.generate(
                              status.receiveStatus.length,
                              (index) => Tab(
                                child: TextLanguage(
                                  titleAr: status.receiveStatus[index].titleAr,
                                  titleEn: status.receiveStatus[index].title,
                                  titleKr: status.receiveStatus[index].titleKr,
                                  style: TextStyle(fontFamily: "nrt-reg"),
                                  ),
                                ),
                              ),
                            ),
                          ),

                      ],
                      Expanded(
                        child: TabBarView(
                          controller: _controller,
                          physics: AlwaysScrollableScrollPhysics(),
                          children: List.generate(
                              status.receiveStatus.length,
                              (index) => _searchController.text.isEmpty
                                  ? ReceiveClientScreen(
                                      statusId: status.receiveStatus[index].id,
                                      type: "suer",
                                    )
                                  : ReceiveSearchListScreen(text: _searchController.text)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
