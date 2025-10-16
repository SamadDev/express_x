import 'package:flutter/material.dart';
import 'package:x_express/features/home/logistic/pages/logistic_detail.dart';

class Logistic extends StatelessWidget {
  const Logistic({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            7,
                (index) => _buildQuickAction(
                'Logistic',
                "assets/images/box.png",context
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(String title, String imagePath,context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Servicedetail()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 30,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
