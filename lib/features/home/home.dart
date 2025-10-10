import 'package:flutter/material.dart';
import 'package:x_express/pages/home/address/pages/address_home.dart';
import 'package:x_express/pages/home/advertisement/advertisement.dart';
import 'package:x_express/pages/home/logistic/pages/logistic_list.dart';


class HomePageNew extends StatefulWidget {
  const HomePageNew({super.key});

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<String> _tabs = [
    'US-A',
    'Dubai',
    'US-A',
    'Turkey',
    'Dubai',
    'US-A',
    'Canada',
    'UK',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget customTabWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Column(
        children: [
          SizedBox(
            height: 48,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      _pageController.jumpToPage(index);
                    },
                    child: Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: _selectedIndex == index ? Color(0xff8b66fd) : Colors.transparent,
                          width: 2,
                        ),
                      )),
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: _selectedIndex == index ? Color(0xff5d3ebd) : Colors.grey,
                          fontSize: 16,
                          fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedTabContent() {
    switch (_selectedIndex) {
      case 0:
        return GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 4,
          ),
          children: const [
            _BrandLogo(name: 'Amazon', image: "amazon.png"),
            _BrandLogo(name: 'Zara', image: "ebay.png"),
            _BrandLogo(name: 'Ebay', image: "zara.png"),
            _BrandLogo(name: 'Amazon', image: "amazon.png"),
            _BrandLogo(name: 'Zara', image: "zara.png"),
            _BrandLogo(name: 'Ebay', image: "ebay.png"),
            _BrandLogo(name: 'Amazon', image: "amazon.png"),
            _BrandLogo(name: 'Zara', image: "zara.png"),
            _BrandLogo(name: 'Ebay', image: "ebay.png"),
          ],
        );
      case 1:
        return Center(
          child: Container(
            alignment: Alignment.center,
            height: 300,
            child: Text('Dubai content'),
          ),
        );
      case 2:
        return Center(
          child: Container(
            alignment: Alignment.center,
            height: 300,
            child: Text('US-A content'),
          ),
        );
      // Add cases for other tabs
      default:
        return Center(
          child: Container(
            alignment: Alignment.center,
            height: 300,
            child: Text('Content for ${_tabs[_selectedIndex]}'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(preferredSize: Size(double.infinity, 60), child: _AppBarWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressHome(),
            Logistic(),
            Advertisement(),
            _SearchWidget(),
            _TimerSelectionWidget(),
            customTabWidget(),
            getSelectedTabContent(),
          ],
        ),
      ),
    );
  }
}


class _TimerSelectionWidget extends StatelessWidget {
  const _TimerSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF5C3A9E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Text(
            'Free delivery offer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          _buildTimeBox('07'),
          const Text(' : ', style: TextStyle(color: Colors.white)),
          _buildTimeBox('14'),
          const Text(' : ', style: TextStyle(color: Colors.white)),
          _buildTimeBox('44'),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        time,
        style: const TextStyle(
          color: Color(0xFF5C3A9E),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for store name...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF5C3A9E),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Filter Store',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: const Color(0xFF5C3A9E),
      title: Image.asset("assets/images/logo.png", height: 30),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const IconButton(
            icon: Icon(Icons.shopping_basket_outlined, color: Color(0xFF5C3A9E)),
            onPressed: null,
          ),
        ),
      ],
    );
  }
}

class _BrandLogo extends StatelessWidget {
  final String name;
  final String image;

  const _BrandLogo({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/$image",
            height: 60,
            width: 60,
            fit: BoxFit.fill,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
