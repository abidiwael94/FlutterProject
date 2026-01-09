import 'package:flutter/material.dart';
import 'package:project_flutter/Models/event.dart';
import 'event_service.dart';
import 'package:project_flutter/core/constants/constants.dart';

class EventFormPage extends StatefulWidget {
  final EventService service;
  final Event? event;

  const EventFormPage({super.key, required this.service, this.event});

  @override
  State<EventFormPage> createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleCtrl;
  late TextEditingController descCtrl;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.event?.title);
    descCtrl = TextEditingController(text: widget.event?.description);
    selectedDate = widget.event?.date;
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate() || selectedDate == null) return;

    final event = Event(
      id: widget.event?.id ?? widget.service.generateId(),
      title: titleCtrl.text.trim(),
      description: descCtrl.text.trim(),
      date: selectedDate!,
    );

    widget.event == null
        ? await widget.service.createEvent(event)
        : await widget.service.updateEvent(event);

    if (mounted) Navigator.pop(context);
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: kLabelStyle),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: kHintTextStyle,
            ),
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Event Date', style: kLabelStyle),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            final d = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              initialDate: selectedDate ?? DateTime.now(),
            );
            if (d != null) setState(() => selectedDate = d);
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            child: Text(
              selectedDate == null
                  ? 'Pick date'
                  : selectedDate!.toLocal().toString().split(" ")[0],
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: save,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
        child: const Text(
          'SAVE EVENT',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.event == null ? 'Create Event' : 'Edit Event'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Title',
                    hint: 'Enter event title',
                    controller: titleCtrl,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Description',
                    hint: 'Enter event description',
                    controller: descCtrl,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  _buildDatePicker(),
                  const SizedBox(height: 20),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
