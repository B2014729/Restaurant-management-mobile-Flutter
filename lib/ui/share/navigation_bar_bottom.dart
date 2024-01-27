import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobileapp/ui/auth/auth_screen.dart';
import 'package:mobileapp/ui/cart/cart_screen.dart';
import 'package:mobileapp/ui/dish/dish_screen.dart';
import 'package:mobileapp/ui/order/order_screen.dart';

class NavigationBarBottom extends StatefulWidget {
  static const routeName = '/navigator-bar';
  final int index;
  const NavigationBarBottom(this.index, {super.key});

  @override
  State createState() => _NavigationBarBottomState();
}

class _NavigationBarBottomState extends State<NavigationBarBottom> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    const DishScreen(),
    const CartScreen(),
    const OrderScreen(),
    const AuthScreen(),
  ];

  @override
  void initState() {
    _currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.orange,
        unselectedItemColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 47, 47, 47),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Đã gọi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.bag_check_sharp),
            label: 'Bàn ăn',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}
