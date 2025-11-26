import 'package:flutter/material.dart';
import "package:x_express/core/config/theme/color.dart";
import 'package:x_express/core/config/language/language.dart';

class AreYouSureDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onApproval;
  final VoidCallback? onCancel;
  final bool showNoteField;
  final Color color;
  final TextEditingController? noteController;
  final String confirmButtonText;

  const AreYouSureDialog({
    required this.title,
    required this.description,
    required this.onApproval,
    required this.color,
    this.onCancel,
    this.showNoteField = false,
    this.noteController,
    this.confirmButtonText = "Approval",
  });

  @override
  Widget build(BuildContext context) {
    final language = words(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: kLightCardBackground,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kLightBlackText,
        ),
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: kLightPlatinum500),
            ),
            if (showNoteField && noteController != null)
              Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: kLightFill,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kLightStroke),
                ),
                child: TextFormField(
                  controller: noteController,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText:
                        language['rejection_reason'] ?? 'Reason for rejection',
                    border: InputBorder.none,
                    hintStyle:
                        const TextStyle(fontSize: 12, color: kLightPlatinum600),
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kLightSurfacePrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            language['cancel'] ?? 'Cancel',
            style: const TextStyle(
              color: kLightText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // If a note is required, validate before proceeding
            if (showNoteField) {
              final note = noteController?.text.trim() ?? "";
              if (note.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(language['rejection_reason_required'] ??
                        'Rejection reason is required'),
                    backgroundColor: kLightError,
                  ),
                );
                return;
              }
            }
            Navigator.of(context).pop();
            onApproval();
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            confirmButtonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
