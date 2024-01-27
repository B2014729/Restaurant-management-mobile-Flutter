import 'package:flutter/material.dart';
import 'package:mobileapp/ui/order/order_detail.dart';

class OrderCard extends StatelessWidget {
  final int idTable;
  const OrderCard(this.idTable, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          OrderDetail.routeName,
          arguments: idTable,
        );
      },
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            width: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 255, 185, 7),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(7, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bàn $idTable',
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
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
