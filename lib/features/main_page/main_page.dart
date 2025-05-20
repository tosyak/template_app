import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ricknotmorty/core/routing/router.gr.dart';

@RoutePage(name: "MainPageRoute")
class MainPage extends StatefulWidget {
  static const routeName = '/main-page';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      homeIndex: 0,
      routes: const [
        CharactersRoute(),
        EpisodesRoute(),
        FavoritesRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
        return Scaffold(
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
            child: _buildBottomTab(tabsRouter.activeIndex, tabsRouter),
          ),
          floatingActionButton: Visibility(
            visible: !keyboardIsOpen,
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: FloatingActionButton(
                tooltip: 'Open Favorites',
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                onPressed: () {
                  tabsRouter.setActiveIndex(2);
                },
                child: Image.asset(
                  'assets/portal.gif',
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: child,
        );
      },
    );
  }

  Widget _buildBottomTab(int selectedIndex, TabsRouter tabsRouter) {
    final tabs = ['characters', 'episodes', 'favorites'];

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      padding: EdgeInsets.symmetric(horizontal: 84.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            text: tabs[0],
            icon: selectedIndex == 0 ? Icons.person_2 : Icons.person_2_outlined,
            isSelected: selectedIndex == 0,
            onTap: () {
              tabsRouter.setActiveIndex(0);
            },
          ),
          TabItem(
              text: tabs[1],
              icon: selectedIndex == 1
                  ? Icons.drive_file_move
                  : Icons.drive_file_move_outline,
              isSelected: selectedIndex == 1,
              onTap: () {
                tabsRouter.setActiveIndex(1);
              }),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const TabItem({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle();
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon),
            Text(
              text,
              style: textStyle.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
