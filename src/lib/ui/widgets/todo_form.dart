import 'package:flutter/material.dart';
import 'package:todo_apps_2/ui/common/ui_helpers.dart';

class TodoForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String? titleError;
  final String? descriptionError;
  final VoidCallback onSave;
  final String submitButtonText;

  const TodoForm({
    required this.titleController,
    required this.descriptionController,
    this.titleError,
    this.descriptionError,
    required this.onSave,
    required this.submitButtonText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              errorText: titleError,
              border: const OutlineInputBorder(),
            ),
          ),
          verticalSpaceMedium,
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              errorText: descriptionError,
              border: const OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          verticalSpaceLarge,
          ElevatedButton(
            onPressed: onSave,
            child: Text(submitButtonText),
          ),
        ],
      ),
    );
  }
}
