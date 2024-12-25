import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps_2/app/app.locator.dart';
import 'package:todo_apps_2/models/todo.dart';
import 'package:todo_apps_2/services/todo_service.dart';

class CreateTodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _navigationService = locator<NavigationService>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String? _titleError;
  String? _descriptionError;

  String? get titleError => _titleError;
  String? get descriptionError => _descriptionError;

  bool _validateInputs() {
    var isValid = true;
    _titleError = null;
    _descriptionError = null;

    if (titleController.text.isEmpty) {
      _titleError = 'Title cannot be empty';
      isValid = false;
    }

    if (descriptionController.text.isEmpty) {
      _descriptionError = 'Description cannot be empty';
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> saveTodo() async {
    try {
      if (!_validateInputs()) return;

      final todo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text,
        description: descriptionController.text,
        createdAt: DateTime.now(),
      );

      _todoService.addTodo(todo);
      await _navigationService.back();
    } catch (e) {
      setError('Failed to create todo. Please try again.');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
