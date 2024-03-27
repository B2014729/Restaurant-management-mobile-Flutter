import 'package:flutter/material.dart';
import 'package:mobileapp/ui/auth/auth_login_screen.dart';
import 'package:mobileapp/ui/auth/auth_manager.dart';
import 'package:mobileapp/ui/auth/auth_screen.dart';
import 'package:mobileapp/ui/cart/cart_manager.dart';
import 'package:mobileapp/ui/cart/cart_screen.dart';
import 'package:mobileapp/ui/dish/dish_manager.dart';
import 'package:mobileapp/ui/dish/dish_note.dart';
import 'package:mobileapp/ui/dish/dish_screen.dart';
import 'package:mobileapp/ui/dish/dish_type_screen.dart';
import 'package:mobileapp/ui/order/order_detail.dart';
import 'package:mobileapp/ui/order/order_manager.dart';
import 'package:mobileapp/ui/order/order_screen.dart';
import 'package:mobileapp/ui/share/navigation_bar_bottom.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartManager()),
        ChangeNotifierProvider(create: (context) => DishManager()),
        ChangeNotifierProvider(create: (context) => AuthManager()),
        ChangeNotifierProvider(create: (context) => OrderManager()),
      ],
      child: Consumer<AuthManager>(
        builder: (context, authmanager, child) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF212325),
            ),
            routes: {
              DishScreen.routeName: (context) => const DishScreen(),
              CartScreen.routeName: (context) => const CartScreen(),
              OrderScreen.routeName: (context) => const OrderScreen(),
              AuthScreen.routeName: (context) => const AuthScreen(),
              AuthLoginScreen.routeName: (context) => const AuthLoginScreen()
            },
            home: (context).read<AuthManager>().isAuthToken()
                ? const NavigationBarBottom(0)
                : const AuthLoginScreen(),

            //home: const AuthLoginScreen(),
            onGenerateRoute: (setting) {
              if (setting.name == NavigationBarBottom.routeName) {
                final index = setting.arguments as int;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return NavigationBarBottom(index);
                  },
                );
              }

              if (setting.name == DishNoteScreen.routeName) {
                final dishId = setting.arguments as int;
                return MaterialPageRoute(
                  builder: (ctx) {
                    // final dishManager = ctx.watch<DishManager>();
                    // DishModel dish = dishManager.findById(dishId)!;
                    return DishNoteScreen(
                      ctx.read<DishManager>().findById(dishId)!,
                    );
                  },
                );
              }

              if (setting.name == DishScreenOnType.routeName) {
                final typeDishId = setting.arguments as int;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return DishScreenOnType(
                      //ctx.read<DishManager>().findById(dishId)!,
                      typeDishId,
                    );
                  },
                );
              }

              if (setting.name == OrderDetail.routeName) {
                final idTable = setting.arguments as int;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return OrderDetail(
                      ctx.read<OrderManager>().getOrderWithIdTable(idTable)!,
                    );
                  },
                );
              }
              return null;
            },

            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
