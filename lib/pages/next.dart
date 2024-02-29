import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'home.dart'; // Assuming the login page is named
import 'package:flutter_svg/flutter_svg.dart';

class next extends StatefulWidget {
  final String username; // Add username parameter
  const next({Key? key, required this.username}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<next> {
  int _selectedIndex = 0;
  int _navBarIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNavBarItemTapped(int index) {
    setState(() {
      _navBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A27),
        title: Text(
          widget.username, // Display username dynamically
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        titleSpacing: 0, // Adjust the spacing here
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Homepage()), // Navigate to the login page
              );
            },
            child: Container(
              height: 35,
              margin: const EdgeInsets.only(right: 15),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Text(
                  'Add Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                border: Border.all(color: Color(0xFFFFFFFF).withOpacity(0.27)),
              ),
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 15), // Add left padding here
          child: Row(
            children: [
              Container(
                child: CircleAvatar(
                  radius: 15, // Adjust the radius as needed
                  backgroundColor: Colors.white, // Set background color for the circle
                  // Add your profile picture here
                ),
              ),
              // Add a spacer to occupy available space
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem('Inflow', 0),
                _buildNavItem('Outflow', 1),
                _buildNavItem('Status', 2),
              ],
            ),
          ),
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A27), // Set background color
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home_icon.svg',
              color: Colors.white,
            ), // Set icon color
            label: 'Home',
            backgroundColor: const Color(0xFF1A1A27), // Match background color
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/search_icon.svg',
              color: Colors.white,
            ), // Set icon color
            label: 'Search',
            backgroundColor: const Color(0xFF1A1A27), // Match background color
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/profile_icon.svg',
              color: Colors.white,
            ), // Set icon color
            label: 'Profile',
            backgroundColor: const Color(0xFF1A1A27), // Match background color
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white, // Change the color of selected item
        unselectedItemColor: Colors.white.withOpacity(0.6), // Set color of unselected items
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        elevation: 0, // Remove elevation
        type: BottomNavigationBarType.fixed, // Ensure all items have same width
        selectedIconTheme: IconThemeData(size: 28), // Adjust icon size
        selectedFontSize: 14, // Adjust font size for selected item
        showSelectedLabels: true, // Show labels for selected items
        showUnselectedLabels: true, // Show labels for unselected items
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _navBarIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: _navBarIndex == index ? Colors.black : Color(0xFF1A1A27),
              fontWeight: _navBarIndex == index ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          _navBarIndex == index
              ? Container(
                  height: 2,
                  width: 45,
                  color: Colors.black,
                )
              : SizedBox(height: 2),
        ],
      ),
    );
  }
}
