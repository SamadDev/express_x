import 'package:x_express/Screens/Order/OrderState/order_tapbar.dart';
import 'package:x_express/Screens/Receives/receive_tapbar.dart';
import 'package:x_express/Screens/home/home.dart';
import 'package:x_express/Utils/exports.dart';

class NavigationButtonScreen extends StatefulWidget {
  final page;
  final tabPage;
  NavigationButtonScreen({this.page, this.tabPage = 0});
  State<NavigationButtonScreen> createState() => _NavigationButtonScreenState();
}

class _NavigationButtonScreenState extends State<NavigationButtonScreen> {
  dynamic selected = 0;
  dynamic selectedTabOrder = 0;

  PageController? controller;

  @override
  void initState() {
    selectedTabOrder = widget.tabPage;
    if (widget.page != null) {
      selected = widget.page;
      controller = PageController(initialPage: widget.page);
    } else {
      controller = PageController();
    }
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      bottomNavigationBar: Consumer<Language>(
        builder: (ctx, language, _) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.grey_between,
          selectedLabelStyle:
              TextStyle(fontSize: 12, fontFamily: 'nrt-reg', fontWeight: FontWeight.w500, color: AppTheme.primary),
          unselectedLabelStyle:
              TextStyle(fontSize: 12, fontFamily: 'nrt-reg', fontWeight: FontWeight.w500, color: AppTheme.grey_between),
          elevation: 1,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/home.png', color: AppTheme.grey_between, width: 20, height: 20),
                activeIcon: Image.asset('assets/icons/home.png', color: AppTheme.primary, width: 21, height: 21),
                label: language.getWords['home'] ?? ""),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/order.png', width: 20, height: 20, color: AppTheme.grey_between),
                activeIcon: Image.asset('assets/icons/order.png', width: 21, height: 21, color: AppTheme.primary),
                label: language.getWords['orderNav'] ?? ""),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/order.png', color: AppTheme.grey_between, width: 20, height: 20),
                activeIcon: Image.asset('assets/icons/order.png', color: AppTheme.primary, width: 21, height: 21),
                label: language.getWords["receives"] ?? ""),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/shipment.png', width: 21, height: 21, color: AppTheme.grey_between),
                activeIcon: Image.asset('assets/icons/shipment.png', width: 28, height: 28, color: AppTheme.primary),
                label: language.getWords["shipments"] ?? ""),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Image.asset('assets/icons/menu.png', color: AppTheme.grey_between, width: 21, height: 21),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Image.asset('assets/icons/menu.png', color: AppTheme.primary, width: 28, height: 28),
                ),
                label: language.getWords["menu"] ?? ""),
          ],
          currentIndex: selected ?? 0,
          onTap: (index) {
            //check if tap on the same page
            setState(() {
              selected = index;
            });
          },
        ),
      ),
      body: [
        HomePage(),
        OrderTapBar(),
        ReceiveTapBar(),
        ShipmentTapBar(),
        AccountScreen(),
      ][selected],
    );
  }
}
