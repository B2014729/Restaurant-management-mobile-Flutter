import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/models/dish_model.dart';
import 'package:mobileapp/ui/dish/dish_card.dart';
import 'package:mobileapp/ui/dish/dish_manager.dart';
import 'package:mobileapp/ui/share/draw.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DishScreen extends StatefulWidget {
  static const routeName = '/dish-screen-home';

  const DishScreen({super.key});

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  List<DishModel> result = [];
  //Future<List<DishModel>> result;
  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/v1/restaurant-management-system/dish/list'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      setState(() {
        List<dynamic> data = jsonData['data'];
        for (var i = 0; i < data.length; i++) {
          Map<String, dynamic> jsonDish = {};
          jsonDish['id'] = data[i]['idmon'];
          jsonDish['price'] = data[i]['gia'];
          jsonDish['name'] = data[i]['tenmon'];
          jsonDish['imageUrl'] = data[i]['hinhanh'];
          jsonDish['type'] = data[i]['idloai'];
          jsonDish['unit'] = data[i]['iddonvitinh'];

          result.add(DishModel.fromJson(jsonDish));
        }
      });
    } else {
      // Handle error if needed
    }
  }

  List<DishModel> search(String searchString, List<DishModel> listDishSearch) {
    if (searchString.isNotEmpty) {
      return listDishSearch
          .where((element) =>
              element.name.toLowerCase().contains(searchString.toLowerCase()))
          .toList();
    }
    return listDishSearch;
  }

  @override
  Widget build(BuildContext context) {
    final isValue = ValueNotifier<bool>(false);
    final DishManager dishManager = (context).watch<DishManager>();

    if (dishManager.itemCount == 0) {
      dishManager.fectDishListFromAPI();
    }

    final dish = context.select<DishManager, List<DishModel>>(
        (dishManager) => dishManager.items);

    if (dish.isNotEmpty) {
      isValue.value = true;
    }

//Connect socket.io
    final socket = IO.io('http://10.0.2.2:8000', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      print('Connected');
    });

    socket.on(
      'ondishpaid',
      (data) {
        print('--------------------------------------------------');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Notification'),
              content: Text(data.toString()),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Beach Restaurant",
          style: GoogleFonts.pacifico(
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(215, 19, 19, 19),
        actions: [
          IconButton(
            onPressed: () {
              //Navigator.pushNamed(context, NotificationScreen.routeName);
            },
            icon: const Icon(Icons.notifications),
            color: Colors.orange,
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: isValue,
        builder: (context, value, child) {
          if (value) {
            return Column(
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(92, 82, 79, 79),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      child: Image.network(
                          'https://studiovietnam.com/wp-content/uploads/2022/10/menu-thuc-an-02-1.jpg'),
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
                    //child: buildSearchField(context),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          result = search(value, dish);
                        });
                      },
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
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 3, 0, 10),
                      child: Text(
                        'Danh sách tất cả món ăn:',
                        style: TextStyle(
                          color: Colors.orange,
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            DishCard(result[index]),
                          ],
                        );
                      }

                      // child: CustomScrollView(
                      //   slivers: <Widget>[
                      //     SliverFixedExtentList(
                      //       itemExtent: 100.0,
                      //       delegate: SliverChildBuilderDelegate(
                      //         childCount: result.length,
                      //         (BuildContext context, int index) {
                      //           return Row(
                      //             children: [
                      //               DishCard(result[index]),
                      //             ],
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  // TextFormField buildSearchField(BuildContext context) {
  //   //Product product;
  //   return TextFormField(
  //     onChanged: (value) => search(value),
  //     style: TextStyle(
  //       color: Colors.white.withOpacity(0.5),
  //     ),
  //     decoration: InputDecoration(
  //       border: InputBorder.none,
  //       hintText: 'Tìm kiếm',
  //       hintStyle: TextStyle(
  //         color: Colors.white.withOpacity(0.5),
  //       ),
  //       prefixIcon: Icon(
  //         Icons.search,
  //         color: Colors.white.withOpacity(0.5),
  //       ),
  //     ),
  //     onFieldSubmitted: (value) => {
  //       // product = context.read<ProductsManager>().findByTitle(value)!,
  //       // Navigator.of(context)
  //       //     .pushNamed(ProductDetail.routeName, arguments: product.id),
  //     },
  //   );
  // }
}
