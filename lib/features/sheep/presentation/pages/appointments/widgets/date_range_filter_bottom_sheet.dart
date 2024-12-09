import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeFilterBottomSheet extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DateRangeFilterBottomSheet({
    this.initialStartDate,
    this.initialEndDate,
    this.firstDate,
    this.lastDate,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _DateRangeFilterBottomSheetState();

  // Helper method to show the bottom sheet
  static Future<DateTimeRange?> show(
    BuildContext context, {
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return showModalBottomSheet<DateTimeRange>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DateRangeFilterBottomSheet(
        initialStartDate: initialStartDate,
        initialEndDate: initialEndDate,
        firstDate: firstDate,
        lastDate: lastDate,
      ),
    );
  }
}

class _DateRangeFilterBottomSheetState
    extends State<DateRangeFilterBottomSheet> {
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    // Set initial dates or use current date
    _startDate = widget.initialStartDate ?? DateTime.now();
    _endDate = widget.initialEndDate ?? DateTime.now();
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2101),
    );

    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        // Ensure end date is not before start date
        if (_endDate.isBefore(_startDate)) {
          _endDate = _startDate;
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate, // Cannot select end date before start date
      lastDate: widget.lastDate ?? DateTime(2101),
    );

    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Date Range',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          // Start Date Selection
          ListTile(
            title: const Text('Start Date'),
            subtitle: Text(
              DateFormat('dd MMM yyyy').format(_startDate),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: _selectStartDate,
            ),
          ),

          // End Date Selection
          ListTile(
            title: const Text('End Date'),
            subtitle: Text(
              DateFormat('dd MMM yyyy').format(_endDate),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: _selectEndDate,
            ),
          ),

          const SizedBox(height: 16),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                ),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Return the selected date range
                  Navigator.of(context)
                      .pop(DateTimeRange(start: _startDate, end: _endDate));
                },
                child: const Text('Apply'),
              ),
            ],
          ),

          // Additional padding for bottom
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
