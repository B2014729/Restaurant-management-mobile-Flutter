import 'package:flutter/material.dart';
import 'package:mobileapp/models/dish_model.dart';
import 'package:mobileapp/ui/cart/cart_manager.dart';
import 'package:mobileapp/ui/share/dialog_utils.dart';
import 'package:provider/provider.dart';

class DishNoteScreen extends StatefulWidget {
  static const routeName = "/dish-note";
  final DishModel dish;
  const DishNoteScreen(this.dish, {super.key});

  @override
  State<DishNoteScreen> createState() => _DishNoteScreenState();
}

class _DishNoteScreenState extends State<DishNoteScreen> {
  final _controller = TextEditingController();
  var quantity = 1;
  @override
  Widget build(BuildContext context) {
    final carts = context.watch<CartManager>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 350,
              child: Image.network(widget.dish.imageUrl),
            ),
            const SizedBox(height: 20),
            Text(
              widget.dish.name,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.fromLTRB(15.0, 0, 0, 5),
              child: Row(
                children: [
                  Text(
                    '* Thêm ghi chú:',
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: buildTextFieldNote(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          '${quantity}',
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      carts.addItem(widget.dish.id, quantity, _controller.text);
                      // print(quantity);
                      // print(widget.dish.id);
                      // print(_controller.text);
                      notificationAddedDish(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField buildTextFieldNote(context) {
    return TextField(
      controller: _controller,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          vertical: 30,
        ),
      ),
    );
  }
}
