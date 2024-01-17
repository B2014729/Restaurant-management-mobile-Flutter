import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobileapp/ui/dish/dish_type_screen.dart';
import 'package:mobileapp/ui/share/navigation_bar_bottom.dart';
// import 'package:provider/provider.dart';

// import '../auth/auth_manager.dart';
// import '../cart/cart_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Row(
              children: <Widget>[
                Icon(Icons.menu),
                Text(' Danh mục sản phẩm'),
              ],
            ),
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(214, 0, 0, 0),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              "Trang chủ",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(context, NavigationBarBottom.routeName,
                  arguments: 0);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Ionicons.trash_bin),
            title: const Text(
              "Lẩu",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                DishScreenOnType.routeName,
                arguments: 4,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Ionicons.file_tray_full),
            title: const Text(
              "Nướng",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                DishScreenOnType.routeName,
                arguments: 7,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Ionicons.fish),
            title: const Text(
              "Hải sản",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                DishScreenOnType.routeName,
                arguments: 8,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Ionicons.add_circle),
            title: const Text(
              "Gỏi",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                DishScreenOnType.routeName,
                arguments: 10,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Ionicons.beer),
            title: const Text(
              'Beer',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                DishScreenOnType.routeName,
                arguments: 3,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Ionicons.pint),
            title: const Text(
              "Nước ngọt",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                DishScreenOnType.routeName,
                arguments: 2,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Ionicons.add_circle),
            title: const Text(
              "Món thêm",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                DishScreenOnType.routeName,
                arguments: 13,
              );
            },
          ),
          const Divider(),
          // ListTile(
          //   leading: const Icon(Ionicons.log_out),
          //   title: const Text(
          //     'Đăng xuất',
          //     style: TextStyle(fontSize: 18),
          //   ),
          //   onTap: () {
          // Navigator.of(context)
          //   ..pop()
          //   ..pushReplacementNamed('/');
          // context.read<AuthManager>().logout();
          //   },
          // ),
        ],
      ),
    );
  }
}
