import 'package:flutter/material.dart';
import 'package:project_flutter/Models/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Use a getter to build the screen list dynamically based on the current user
  List<Widget> get _screens => [
        const EventsScreen(),
        const ReservationsScreen(),
        const FavoritesScreen(),
        ProfileScreen(user: widget.user),
        if (widget.user.role == 'admin') const AdminScreen(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = widget.user.role == 'admin';

    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(_selectedIndex, isAdmin)),
        backgroundColor: const Color(0xFF398AE5),
      ),
      body: _screens[_selectedIndex], 
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF398AE5),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          const BottomNavigationBarItem(icon: Icon(Icons.book_online), label: 'Reservations'),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          if (isAdmin)
            const BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: 'Admin'),
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


// --- Events Screen ---
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('📅 Events Screen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}

// --- Reservations Screen ---
class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('🎟️ My Reservations', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}

// --- Favorites Screen ---
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('❤️ Favorites Screen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}

// --- Profile Screen ---
class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 80, color: Colors.blue),
          Text('Profile: ${user.username}', style: const TextStyle(fontSize: 24)),
          Text('Role: ${user.role}', style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

// --- Admin Screen ---
class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('🛡️ Admin Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
    );
  }
}