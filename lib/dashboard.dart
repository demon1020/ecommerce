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
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    AddProductPage(),
    ProfilePage(),
    CheckoutPage(),
  ];

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
            icon: Icon(Icons.home),
            backgroundColor: AppColor.primary,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColor.primary,
            icon: Icon(Icons.add),
            label: 'Add Products',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColor.primary,
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColor.primary,
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
