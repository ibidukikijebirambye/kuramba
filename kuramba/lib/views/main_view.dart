import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/current_user_provider.dart';

import 'feed_view.dart';
import 'contacts_view.dart';
import 'profile_view.dart';
import 'search_view.dart';
import '../views/settings/main_settings_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  PageController controller = PageController(initialPage: 1);
  final List<Map<String, Object>> views = [
    {
      'view': FeedView(),
      'title': 'Feed',
      'icon': const Icon(
        Icons.chat_bubble_rounded,
      ),
    },
    {
      'view': ProfileView(),
      'title': 'Profile',
      'icon': const Icon(
        Icons.person_rounded,
      ),
    },
    {
      'view': ContactsView(),
      'title': 'Contacts',
      'icon': const Icon(
        Icons.group_rounded,
      ),
    },
  ];

  var selectedViewIndex = 1;

  void selectView(int index) {
    setState(() {
      selectedViewIndex = index;
      controller.animateToPage(
        index,
        duration: Duration(milliseconds: 450),
        curve: Curves.ease,
      );
    });
  }

  var _isInit = false;

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      await Provider.of<CurrentUserProvider>(
        context,
        listen: false,
      ).fetchData();
      setState(() {
        _isInit = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          views[selectedViewIndex]['title'],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 5,
            ),
            child: selectedViewIndex == 2
                ? IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => SearchView(),
                      ),
                    ),
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.add,
                    ),
                    onPressed: () {},
                  ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.settings_rounded),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => MainSettingsView(),
            ),
          ),
        ),
      ),
      body: _isInit
          ? PageView(
              children: [
                views[0]['view'],
                views[1]['view'],
                views[2]['view'],
              ],
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  selectedViewIndex = index;
                });
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectView,
        currentIndex: selectedViewIndex,
        items: views.map((view) {
          return BottomNavigationBarItem(
            icon: view['icon'],
            label: view['title'],
          );
        }).toList(),
      ),
    );
  }
}
