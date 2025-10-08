import 'package:flutter/material.dart';
import 'package:x_express/pages/home/address/pages/address_list.dart';

class AddressHome extends StatelessWidget {
  const AddressHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AddressListScreen()));
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Delivery Address',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
