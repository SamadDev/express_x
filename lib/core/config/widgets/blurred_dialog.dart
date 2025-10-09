import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:x_express/core/config/widgets/globalText.dart';

class BlurredDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final double blurIntensity;
  final bool isFullWidth;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? titlePadding;

  const BlurredDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.blurIntensity = 5.0,
    this.isFullWidth = false,
    this.contentPadding,
    this.titlePadding,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurIntensity,
        sigmaY: blurIntensity,
      ),
      child: Dialog(
        backgroundColor: Colors.white.withValues(alpha: 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 250,
          width: isFullWidth ? MediaQuery.of(context).size.width - 20 : null,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: titlePadding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: GlobalText(
                  title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: GlobalText(
                  content,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: GlobalText(
                        cancelText ?? "Ok",
                        fontSize: 14,
                      ),
                    ),
                    if (confirmText != null) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: onConfirm,
                        child: GlobalText(
                          confirmText ?? "Confirm",
                          fontSize: 14,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

