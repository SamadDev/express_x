import 'package:x_express/Screens/UserForm/OrderUser/order_user.dart';
import 'package:x_express/Utils/exports.dart';

class NavigationUserScreen extends StatefulWidget {
  final page;
  final tabPage;
  NavigationUserScreen({this.page, this.tabPage = 0});
  State<NavigationUserScreen> createState() => _NavigationUserScreenState();
}

class _NavigationUserScreenState extends State<NavigationUserScreen> {
  dynamic selected = 0;
  dynamic selectedTabOrder = 0;

  PageController? controller;

  @override
  void initState() {
    print("user access token is: ${Auth.token}");
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
                icon: Image.asset('assets/icons/order.png', width: 20, height: 20, color: AppTheme.grey_between),
                activeIcon: Image.asset('assets/icons/order.png', width: 21, height: 21, color: AppTheme.primary),
                label: "Orders" ?? ""),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/shipment.png', color: AppTheme.grey_between, width: 20, height: 20),
                activeIcon: Image.asset('assets/icons/shipment.png', color: AppTheme.primary, width: 21, height: 21),
                label: "Receives" ?? ""),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/profile.png', color: AppTheme.grey_between, width: 20, height: 20),
                activeIcon: Image.asset('assets/icons/profile.png', color: AppTheme.primary, width: 21, height: 21),
                label: "Profile" ?? ""),
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
        OrderUserListScreen(),
        OrderReceiveListScreen(),
        AccountScreen(type: "user"),
      ][selected],
    );
  }
}
