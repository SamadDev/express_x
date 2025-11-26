import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';

class TimerSelectionWidget extends StatelessWidget {
  const TimerSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kLightPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Text(
            'Free delivery offer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          _buildTimeBox('07'),
          const Text(' : ', style: TextStyle(color: Colors.white)),
          _buildTimeBox('14'),
          const Text(' : ', style: TextStyle(color: Colors.white)),
          _buildTimeBox('44'),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        time,
        style: const TextStyle(
          color: kLightPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
