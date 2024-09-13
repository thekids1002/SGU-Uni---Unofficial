import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sgu_uni/models/auth/user.dart';
import 'package:sgu_uni/utils/shared_preferences_utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> widgetOptions = <Widget>[
    Text(
      'Index 0: Trang chủ',
      style: optionStyle,
    ),
    Text(
      'Index 1: TKB',
      style: optionStyle,
    ),
    Text(
      'Index 2: Thông báo',
      style: optionStyle,
    ),
    Text(
      'Index 3: Cá nhân',
      style: optionStyle,
    ),
  ];

  static const List<BottomNavigationBarItem> bottomBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
        color: Colors.white,
        size: 25,
      ),
      label: 'Trang chủ',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.calendar_month_rounded,
        color: Colors.white,
        size: 25,
      ),
      label: 'TKB',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.notifications_active_outlined,
        color: Colors.white,
        size: 25,
      ),
      label: 'Thông báo',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person_outline_sharp,
        color: Colors.white,
        size: 25,
      ),
      label: 'Cá nhân',
    ),
  ];
  User? currentUser;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/logo/logo.png",
                width: 40,
                height: 40,
              ),
              const Text(
                "Trường Đại Học\nSài Gòn",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          leadingWidth: MediaQuery.of(context).size.width * 0.45,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.51,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: 250,
                        child: Text(
                          'Xin chào,\n${currentUser!.name?.toUpperCase()}',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.4,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      "assets/icons/no-profile-picture.svg",
                      width: 40,
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: currentUser != null
              ? widgetOptions.elementAt(_selectedIndex)
              : const CircularProgressIndicator(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          type: BottomNavigationBarType.fixed,
          items: bottomBarItems,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 192, 191, 190),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget Home() {
    return Column(
      children: [
        Text('Hello, ${currentUser!.name}'),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    User? user = await SharedPreferencesUtils.getObject(
      'currentUser',
      User.fromJson,
    );
    setState(() {
      currentUser = user;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
