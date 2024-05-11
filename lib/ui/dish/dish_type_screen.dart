import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/models/dish_model.dart';
import 'package:mobileapp/ui/dish/dish_card.dart';
import 'package:mobileapp/ui/dish/dish_manager.dart';
import 'package:mobileapp/ui/share/draw.dart';
import 'package:mobileapp/ui/share/navigation_bar_bottom.dart';

import 'package:provider/provider.dart';

class DishScreenOnType extends StatefulWidget {
  static const routeName = '/dish-screen-oftype';
  final int typeDishId;
  const DishScreenOnType(this.typeDishId, {super.key});

  @override
  State<DishScreenOnType> createState() => _DishScreenOnTypeState();
}

class _DishScreenOnTypeState extends State<DishScreenOnType> {
  @override
  Widget build(BuildContext context) {
    final dish = context.select<DishManager, List<DishModel>>(
        (dishManager) => dishManager.itemsOnType(widget.typeDishId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách món",
          style: GoogleFonts.pacifico(
            fontSize: 26,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(215, 19, 19, 19),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                NavigationBarBottom.routeName,
                arguments: 1,
              );
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.orange,
            ),
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.white, //Set color cho icon drawer
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 12, 0, 10),
            child: Text(
              'Wellcome to Beach Restaurant',
              style: TextStyle(
                color: Colors.orange,
                // fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: buildSearchField(context),
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 3, 0, 10),
                child: Text(
                  'Danh sách_:',
                  style: TextStyle(
                    color: Colors.orange,
                    // fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverFixedExtentList(
                  itemExtent: 100.0,
                  delegate: SliverChildBuilderDelegate(
                    childCount: dish.length,
                    (BuildContext context, int index) {
                      return Row(
                        children: [
                          DishCard(dish[index]),
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

  TextFormField buildSearchField(BuildContext context) {
    //Product product;
    return TextFormField(
      style: TextStyle(
        color: Colors.white.withOpacity(0.5),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Tìm kiếm',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      onFieldSubmitted: (value) => {
        // product = context.read<ProductsManager>().findByTitle(value)!,
        // Navigator.of(context)
        //     .pushNamed(ProductDetail.routeName, arguments: product.id),
      },
    );
  }
}
