import 'package:flutter/material.dart';
import 'package:mobileapp/models/dish_model.dart';
import 'package:mobileapp/ui/cart/cart_manager.dart';
import 'package:mobileapp/ui/dish/dish_note.dart';
import 'package:mobileapp/ui/share/dialog_utils.dart';
import 'package:provider/provider.dart';

class DishCard extends StatefulWidget {
  final DishModel dish;

  const DishCard(this.dish, {super.key});

  @override
  State<DishCard> createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final carts = context.watch<CartManager>();
    return Row(
      children: [
        SizedBox(
          width: 250,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                DishNoteScreen.routeName,
                arguments: widget.dish.id,
              );
            },
            child: SizedBox(
              height: 95,
              child: Row(children: [
                SizedBox(
                  height: 80,
                  width: 100,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.dish.imageUrl),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.dish.name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(
              () {
                if (quantity > 1) {
                  quantity--;
                }
              },
            );
          },
          icon: Icon(
            Icons.remove,
            color: Colors.white.withOpacity(0.5),
            size: 14,
          ),
        ),
        Text(
          '$quantity',
          style: const TextStyle(color: Colors.orange),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              quantity++;
            });
          },
          icon: Icon(
            Icons.add,
            color: Colors.white.withOpacity(0.5),
            size: 14,
          ),
        ),
        SizedBox(
          width: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color.fromARGB(255, 2, 185, 8).withAlpha(22),
            ),
            onPressed: () {
              carts.addItem(widget.dish.id, quantity, '');
              setState(() {
                quantity = 1;
              });
              //Show notification
              notificationAddedDish(context);
            },
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}
