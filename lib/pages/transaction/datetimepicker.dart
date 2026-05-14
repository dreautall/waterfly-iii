import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:waterflyiii/extensions.dart';

bool _savingInProgress = false; // :TODO:

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({
    super.key,
    required this.initialDateTime,
    required this.onDateTimeChanged,
  });

  final tz.TZDateTime initialDateTime;
  final ValueChanged<tz.TZDateTime> onDateTimeChanged;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late tz.TZDateTime _selectedDateTime;
  late TextEditingController _dateTextController;
  late TextEditingController _timeTextController;

  final Logger log = Logger("Pages.Transaction.DateTimePicker");

  @override
  void initState() {
    super.initState();

    log.finest(() => "initState()");
    _selectedDateTime = widget.initialDateTime;
    _dateTextController = TextEditingController(
      text: DateFormat.yMMMd().format(_selectedDateTime),
    );
    _timeTextController = TextEditingController(
      text: DateFormat.Hm().format(_selectedDateTime),
    );
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    _timeTextController.dispose();

    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      locale: Locale(
        Intl.defaultLocale!.split('_').first,
        Intl.defaultLocale!.split('_').last,
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDateTime = tz.TZDateTime.from(
        _selectedDateTime.copyWith(
          year: pickedDate.year,
          month: pickedDate.month,
          day: pickedDate.day,
        ),
        _selectedDateTime.location,
      );
      _dateTextController.text = DateFormat.yMMMd().format(_selectedDateTime);
      widget.onDateTimeChanged(_selectedDateTime);
    });
  }

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedDateTime.getTimeOfDay(),
    );

    if (pickedTime == null) {
      return;
    }

    setState(() {
      _selectedDateTime = _selectedDateTime.setTimeOfDay(pickedTime);
      _timeTextController.text = DateFormat.Hm().format(_selectedDateTime);
      widget.onDateTimeChanged(_selectedDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    log.finest("build()");

    return Row(
      children: <Widget>[
        IntrinsicWidth(
          child: TextFormField(
            enabled: !_savingInProgress,
            controller: _dateTextController,
            decoration: InputDecoration(
              //prefixIcon: Icon(Icons.calendar_month),
              border: const OutlineInputBorder(),
              filled: _savingInProgress,
            ),
            readOnly: true,
            onTap: _pickDate,
          ),
        ),
        const SizedBox(width: 16),
        IntrinsicWidth(
          child: TextFormField(
            enabled: !_savingInProgress,
            controller: _timeTextController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              filled: _savingInProgress,
            ),
            readOnly: true,
            onTap: _pickTime,
          ),
        ),
      ],
    );
  }
}
