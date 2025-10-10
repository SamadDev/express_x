import 'package:flutter/material.dart';
import 'package:x_express/core/config/language/language.dart';
import 'package:provider/provider.dart';
import 'package:x_express/core/config/assets/app_images.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// Global Date Filter Service
class DateFilterService {
  static final DateFilterService _instance = DateFilterService._internal();
  factory DateFilterService() => _instance;
  DateFilterService._internal();

  DateTime? _startDate;
  DateTime? _endDate;

  // Stream controllers for reactive updates
  final ValueNotifier<DateTime?> startDateNotifier = ValueNotifier<DateTime?>(null);
  final ValueNotifier<DateTime?> endDateNotifier = ValueNotifier<DateTime?>(null);

  // Getters
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  bool get hasDateRange => _startDate != null && _endDate != null;

  // Setters with notifications
  void setDateRange(DateTime? start, DateTime? end) {
    _startDate = start;
    _endDate = end;
    startDateNotifier.value = start;
    endDateNotifier.value = end;
  }

  void clearDates() {
    setDateRange(null, null);
  }

  String get formattedRange {
    // Use English fallback; UI should localize when displaying
    if (!hasDateRange) return 'No dates selected';
    return '${_formatDate(_startDate!)} - ${_formatDate(_endDate!)}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// Reusable Date Filter Widget
class DateFilterButton extends StatefulWidget {
  final VoidCallback? onDateSelected;
  final bool showSelectedDates;

  const DateFilterButton({
    Key? key,
    this.onDateSelected,
    this.showSelectedDates = true,
  }) : super(key: key);

  @override
  _DateFilterButtonState createState() => _DateFilterButtonState();
}

class _DateFilterButtonState extends State<DateFilterButton> {
  final DateFilterService _dateService = DateFilterService();
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  void initState() {
    super.initState();
    // Initialize controller with existing dates
    if (_dateService.hasDateRange) {
      _controller.selectedRange = PickerDateRange(
        _dateService.startDate,
        _dateService.endDate,
      );
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final PickerDateRange range = args.value;
      _dateService.setDateRange(range.startDate, range.endDate);
    }
  }

  void _showDatePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final language = Provider.of<Language>(context, listen: false).getWords;
        return AlertDialog(
          title: Text(language['select_date_range']),
          content: Container(
            height: 350,
            width: 300,
            child: SfDateRangePicker(
              controller: _controller,
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: _onSelectionChanged,
              initialSelectedRange:
                  _dateService.hasDateRange ? PickerDateRange(_dateService.startDate, _dateService.endDate) : null,
              showActionButtons: true,
              onSubmit: (value) {
                Navigator.of(context).pop();
                if (widget.onDateSelected != null) {
                  widget.onDateSelected!();
                }
              },
              onCancel: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap:()=> _showDatePicker,
          child: Image.asset(AppImages.filter),
        ),
        if (widget.showSelectedDates) ...[
          SizedBox(height: 10),
          ValueListenableBuilder<DateTime?>(
            valueListenable: _dateService.startDateNotifier,
            builder: (context, startDate, child) {
              return ValueListenableBuilder<DateTime?>(
                valueListenable: _dateService.endDateNotifier,
                builder: (context, endDate, child) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _dateService.formattedRange,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ],
    );
  }
}
