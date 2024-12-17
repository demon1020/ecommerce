import 'core.dart';
import 'features/add_product/presentation/pages/add_product_page.dart';
import 'features/checkout/presentation/pages/checkout_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Index to track the currently selected bottom navigation item
  int _selectedIndex = 0;

  // List of screens to display based on the bottom navigation selection
  final List<Widget> _screens = [
    HomePage(),
    AddProductPage(),
    ProfilePage(),
    CheckoutPage(),
  ];

  // Function to handle item selection from BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display screen based on selected index
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        selectedLabelStyle: TextStyle(color: Colors.blueAccent),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.black),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
