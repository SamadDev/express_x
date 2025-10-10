import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:x_express/core/config/language/language.dart';
import 'package:provider/provider.dart';


Future<Map<String, DateTime?>?> showDateRangePickerWidget(BuildContext context) async {
  DateTime? startDate;
  DateTime? endDate;

  return await showDialog<Map<String, DateTime?>>(
    context: context,
    builder: (BuildContext context) {
      final language = Provider.of<Language>(context, listen: false).getWords;
      return StatefulBuilder(
        builder: (context, setState) {

          return AlertDialog(
            title: Text(language['select_date_range']),
            content: Container(
              height: 350,
              width: 300,
              child: SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is PickerDateRange) {
                    final PickerDateRange range = args.value;
                    setState(() {
                      startDate = range.startDate;
                      endDate = range.endDate;
                    });
                  }
                },
                showActionButtons: true,
                onSubmit: (value) {
                  if (startDate != null && endDate != null) {
                    Navigator.of(context).pop({
                      'startDate': startDate,
                      'endDate': endDate,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(language['please_select_both_start_and_end_dates'])),
                    );
                  }
                },
                onCancel: () {
                  Navigator.of(context).pop(null);
                },
              ),
            ),
          );
        },
      );
    },
  );
}
