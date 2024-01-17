import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Xóa món?'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Hủy bỏ'),
        ),
        TextButton(
          child: const Text('Xóa'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Lỗi'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}

ScaffoldMessengerState notificationAddedDish(BuildContext context) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Colors.green,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Đã thêm món",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
}

ScaffoldMessengerState notificationOrderSuccessful(BuildContext context) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Colors.green,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Đã gọi món",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
}
