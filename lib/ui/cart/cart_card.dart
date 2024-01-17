import 'package:flutter/material.dart';
import 'package:mobileapp/models/cart_model.dart';
import 'package:mobileapp/models/dish_model.dart';
import 'package:mobileapp/ui/cart/cart_manager.dart';
import 'package:mobileapp/ui/dish/dish_manager.dart';
import 'package:mobileapp/ui/share/dialog_utils.dart';
import 'package:provider/provider.dart';

class CartCard extends StatefulWidget {
  final CartModel cart;

  const CartCard(this.cart, {super.key});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int quantity = 1;
  @override
  void initState() {
    super.initState();
    quantity = widget.cart.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final carts = context.watch<CartManager>();
    final dishManager = context.watch<DishManager>();
    final dish = dishManager.findById(widget.cart.dishId);

    return Dismissible(
        key: ValueKey(widget.cart.id),
        background: Container(
          color: Colors.black,
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete,
            color: Colors.red,
            size: 40,
          ),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showConfirmDialog(context, 'Món ăn sẽ bị xóa khỏi danh sách.');
        },
        onDismissed: (direction) {
          carts.clearItem(dish.id);
        },
        child: builItemCard(carts, dish!));
  }

  Widget builItemCard(CartManager carts, DishModel dish) {
    return SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 70,
            width: 120,
            child: CircleAvatar(
              backgroundImage: NetworkImage(dish.imageUrl),
            ),
          ),
          SizedBox(
            width: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dish.name,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.cart.note,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 120,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        if (quantity > 1) {
                          carts.reduceDish(dish.id);
                          quantity--;
                        }
                      },
                    );
                  },
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                Text(
                  '$quantity',
                  style: const TextStyle(color: Colors.orange),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      carts.increaseDish(dish.id);
                      quantity++;
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     print(quantity);
          //     print(dish.id);
          //   },
          //   icon: const Icon(
          //     Icons.check,
          //     color: Colors.orange,
          //   ),
          // ),
        ],
      ),
    );
  }
}
