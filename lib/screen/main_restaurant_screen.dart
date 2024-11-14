import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../component/restaurant_app_bar.dart';

class MainRestaurantScreen extends StatelessWidget {
  final Widget child;

  const MainRestaurantScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check the screen width
          if (constraints.maxWidth < 600) {
            // Use BottomNavigationBar for screens less than 600 pixels wide (mobile)
            return _buildMobileLayout(context);
          } else {
            // Use NavigationRail for larger screens (tablet, web)
            return _buildTabletLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const RestaurantAppBar(),
      body: child, // The current selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.onSecondary,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/favorite');
              break;
            case 2:
              context.go('/setting');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        showSelectedLabels: true,
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        NavigationRail(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle the menu button press
              print("Menu button pressed");
            },
          ),
          backgroundColor: colorScheme.onSecondary,
          selectedIndex: _calculateSelectedIndex(context),
          onDestinationSelected: (int index) {
            switch (index) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/favorite');
                break;
              case 2:
                context.go('/setting');
                break;
            }
          },
          labelType: NavigationRailLabelType.selected,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.favorite),
              label: Text('Favorite'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 0.5, width: 1),
        // The main content area
        Expanded(child: child),
      ],
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/favorite')) {
      return 1;
    }
    if (location.startsWith('/setting')) {
      return 2;
    }
    return 0;
  }
}