import 'package:flutter/material.dart';
import 'package:project_flutter/Models/event.dart';
import 'event_service.dart';

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
      adminId: widget.event?.adminId ?? "zalfhlkhzfhpfihiafihae",
    );

    widget.event == null
        ? await widget.service.createEvent(event)
        : await widget.service.updateEvent(event);

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.event == null ? "Create Event" : "Edit Event")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(selectedDate == null
                    ? "Pick date"
                    : selectedDate!.toLocal().toString().split(" ")[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  if (d != null) setState(() => selectedDate = d);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: save, child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
