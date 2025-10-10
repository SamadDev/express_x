import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/core/config/routes/routes.dart';

class SuccessPage extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final String nextRoute;
  final bool isPasswordReset;

  const SuccessPage({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.nextRoute,
    this.isPasswordReset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Success graphic
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green[50],
                      ),
                      child: Stack(
                        children: [
                          // Main circle
                          Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[100],
                              ),
                              child: Icon(
                                isPasswordReset ? Icons.lock_reset : Icons.check_circle,
                                size: 60,
                                color: Colors.green[600],
                              ),
                            ),
                          ),
                          // Decorative dots around the circle
                          ...List.generate(8, (index) {
                            final angle = (index * 45.0) * (3.14159 / 180);
                            final radius = 90.0;
                            final x = 100 + radius * (angle / 3.14159);
                            final y = 100 + radius * (angle / 3.14159);
                            
                            return Positioned(
                              left: x - 8,
                              top: y - 8,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index % 2 == 0 ? Colors.green[300] : Colors.orange[300],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Title
                    GlobalText(
                      title,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: kLightTitle,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Message
                    GlobalText(
                      message,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kLightGrayText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Action button
              Container(
                width: double.infinity,
                height: 56,
                margin: const EdgeInsets.only(bottom: 32),
                decoration: BoxDecoration(
                  color: kLightPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: kLightPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context, 
                      nextRoute, 
                      (route) => false
                    );
                  },
                  child: GlobalText(
                    buttonText,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
