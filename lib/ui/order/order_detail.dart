import 'package:flutter/material.dart';

import 'package:mobileapp/models/order_model.dart';
import 'package:mobileapp/ui/order/order_manager.dart';
import 'package:mobileapp/ui/share/dialog_utils.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  static const routeName = "/order-detail";
  final OrderModel order;
  const OrderDetail(this.order, {super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    final orderManager = (context).watch<OrderManager>();
    final detailOrder = widget.order.getListDishInOrder();
    int total = widget.order.totalPayment();
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
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color.fromARGB(255, 255, 178, 63),
                  ),
                ),
                Text(
                  'Thông tin gọi món bàn ${widget.order.idTable}',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 255, 178, 63),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Tên món',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.amber[300],
                  ),
                ),
                Text(
                  'Số lượng x giá',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.amber[300],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: detailOrder.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 30, 30, 30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              '${detailOrder[index]['dishName']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: Text(
                            '${detailOrder[index]['quantity']} x ${detailOrder[index]['dishPrice']}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Tổng thanh toán:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '$total vnđ',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      orderManager.clearOrder(widget.order.idTable);
                      notificationRequestBill(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 206, 151, 1),
                    ),
                    child: const Text('Xuất hóa đơn'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
