import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/models/cart_model.dart';
import 'package:mobileapp/models/order_model.dart';
import 'package:mobileapp/services/order_service.dart';
import 'package:mobileapp/ui/auth/auth_manager.dart';
import 'package:mobileapp/ui/cart/cart_card.dart';
import 'package:mobileapp/ui/cart/cart_manager.dart';
import 'package:mobileapp/ui/order/order_manager.dart';
import 'package:mobileapp/ui/share/dialog_utils.dart';
import 'package:mobileapp/ui/share/draw.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cart-screen";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int> listItems = [0, 1]; // Danh sach trang thai dat mon

  final _controller = TextEditingController();
  final _statusController = TextEditingController();
  int status = 0; // Luu trang thai dat mon

  @override
  Widget build(BuildContext context) {
    final carts = context.watch<CartManager>();
    final orderManager = context.watch<OrderManager>();
    List<CartModel> cartItems = carts.dishs;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order',
          style: GoogleFonts.pacifico(
            fontSize: 26,
          ),
        ),
        backgroundColor: const Color.fromARGB(215, 19, 19, 19),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: DropdownMenu<int>(
                    textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                    ),
                    controller: _statusController,
                    initialSelection: listItems.first,
                    requestFocusOnTap: true,
                    label: Text(
                      'Trạng thái',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    onSelected: (int? value) {
                      setState(
                        () {
                          status = value!;
                        },
                      );
                    },
                    dropdownMenuEntries: listItems.map<DropdownMenuEntry<int>>(
                      (int value) {
                        var label = '';
                        if (value == 0) {
                          label = 'Mới';
                        } else {
                          label = 'Thêm';
                        }
                        return DropdownMenuEntry<int>(
                          value: value,
                          label: label,
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Bàn',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                      ),
                      border: const OutlineInputBorder(),
                      focusColor: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    if (_controller.text != '') {
                      if (cartItems.isNotEmpty) {
                        OrderModel data = OrderModel(
                          idTable: int.parse(_controller.text),
                          status: status,
                          token: (context).read<AuthManager>().getToken,
                          dishList: cartItems,
                        );

                        OrderService.order(data);

                        if (status == 0) {
                          orderManager.addOrder(data);
                        } else {
                          orderManager.updateOrder(
                              cartItems, int.parse(_controller.text));
                        }

                        carts.clearAllItems();
                        notificationOrderSuccessful(context);
                      } else {
                        showErrorDialog(context, "Không có món ăn nào.");
                      }
                    } else {
                      showErrorDialog(context, "Số bàn không để trống.");
                    }
                  },
                  child: const Text("ORDER"),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Danh sách món ăn_:',
            style: TextStyle(color: Colors.orange),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverFixedExtentList(
                  itemExtent: 100.0,
                  delegate: SliverChildBuilderDelegate(
                    childCount: cartItems.length,
                    (BuildContext context, int index) {
                      return Row(
                        children: [
                          CartCard(cartItems[index]),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
