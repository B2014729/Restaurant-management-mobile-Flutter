import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/models/order_model.dart';
import 'package:mobileapp/ui/order/order_card.dart';
import 'package:mobileapp/ui/order/order_manager.dart';
import 'package:mobileapp/ui/share/draw.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "/order-screen";
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderManager = (context).watch<OrderManager>();

    List<OrderModel> ordersHalfFirst = orderManager.ordersHalfFirst;
    List<OrderModel> ordersHalfFinal = orderManager.ordersHalfFinal;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dining table list',
          style: GoogleFonts.pacifico(
            fontSize: 26,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(215, 19, 19, 19),
        iconTheme: const IconThemeData(
          color: Colors.white, //Set color cho icon drawer
        ),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'Danh sách bàn',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ordersHalfFirst.length,
                    itemBuilder: (BuildContext context, index) {
                      if (ordersHalfFirst.isNotEmpty) {
                        return OrderCard(ordersHalfFirst[index].idTable);
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ordersHalfFinal.length,
                    itemBuilder: (BuildContext context, index) {
                      if (ordersHalfFinal.isNotEmpty) {
                        return OrderCard(ordersHalfFinal[index].idTable);
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
