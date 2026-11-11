import 'package:flutter/material.dart';
import 'package:zoma_clone_flutter/constant/colors.dart';
import 'package:zoma_clone_flutter/constant/textstyles.dart';
import 'package:zoma_clone_flutter/ui/profile/fifth.dart';
import 'package:zoma_clone_flutter/ui/delivery/first.dart';
import 'package:zoma_clone_flutter/ui/explore/fourth.dart';
import 'package:zoma_clone_flutter/ui/dineIn/second.dart';
import 'package:zoma_clone_flutter/ui/Progold/third.dart';
import 'package:zoma_clone_flutter/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    FirstPage(),
    SecondPage(),
    ThirdPage(),
    FourthPage(),
    FifthPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.whiteColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: 'Go Out',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Gold',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.blackColor,
        unselectedItemColor: AppColors.primaryTextColorGrey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: _selectedIndex == 2 || _selectedIndex == 4
            ? Container(
                child: _widgetOptions.elementAt(_selectedIndex),
              )
            : Container(
                color: AppColors.whiteColor,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 15.0, right: 10),
                          child: Icon(
                            Icons.location_on_outlined,
                            size: 35,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  'Home',
                                  textAlign: TextAlign.left,
                                  style: TextStyles.actionTitle,
                                ),
                                Text(
                                  'MG Road Bangalore',
                                  textAlign: TextAlign.left,
                                  style: TextStyles.subText,
                                ),
                                Divider(
                                  color: AppColors.blackColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.payment,
                          color: AppColors.blackColor,
                          size: 25,
                        ),
                      ],
                    ),
                    const AppSearchBar('Search for restaurants, cuisines...'),
                    Expanded(
                      child: _widgetOptions.elementAt(_selectedIndex),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
