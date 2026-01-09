import 'package:flutter/material.dart';
import 'package:project_flutter/Models/user.dart';
import 'package:project_flutter/Models/user_role.dart';
import 'package:project_flutter/features/events/presentation/event_list_screen.dart';
import 'package:project_flutter/features/events/providers/event_provider.dart';
import 'package:project_flutter/features/admin/admin_screen.dart';
import 'package:project_flutter/features/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> get _screens {

  final screens = [
    // On met EventProvider autour de EventListScreen et on passe le user correctement
    ChangeNotifierProvider(
      create: (_) => EventProvider(),
      child: EventListScreen(user: widget.user), // <-- user passe ici
    ),
    const ReservationsScreen(),
    const FavoritesScreen(),
    ProfileScreen(userId: widget.user.id),
  ];

  if (widget.user.role == UserRole.admin) {
    screens.add(AdminPage(user: widget.user));
  }

  return screens;
}

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = widget.user.role == UserRole.admin;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(_selectedIndex, isAdmin)),
        backgroundColor: const Color(0xFF398AE5),
      ),
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Prevent invalid index
          if (index < _screens.length) {
            _onItemTapped(index);
          }
        },
        selectedItemColor: const Color(0xFF398AE5),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Reservations',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          if (widget.user.role == UserRole.admin)
            const BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings),
              label: 'Admin',
            ),
        ],
      ),
    );
  }

  String _getAppBarTitle(int index, bool isAdmin) {
    List<String> titles = ['Events', 'Reservations', 'Favorites', 'Profile'];
    if (isAdmin) titles.add('Admin Panel');
    return titles[index];
  }
}

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '🎟️ My Reservations',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '❤️ Favorites Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
