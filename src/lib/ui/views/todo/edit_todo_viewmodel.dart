import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps_2/app/app.locator.dart';
import 'package:todo_apps_2/models/todo.dart';
import 'package:todo_apps_2/services/todo_service.dart';

class EditTodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _navigationService = locator<NavigationService>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String? _titleError;
  String? _descriptionError;
  Todo? _todo;

  String? get titleError => _titleError;
  String? get descriptionError => _descriptionError;

  void init(String todoId) {
    try {
      _todo = _todoService.getTodoById(todoId);
      if (_todo != null) {
        titleController.text = _todo!.title;
        descriptionController.text = _todo!.description;
      } else {
        setError('Todo not found');
      }
    } catch (e) {
      setError('Failed to load todo');
    }
  }

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

  Future<void> updateTodo() async {
    try {
      if (!_validateInputs() || _todo == null) return;

      final updatedTodo = _todo!.copyWith(
        title: titleController.text,
        description: descriptionController.text,
      );

      _todoService.updateTodo(updatedTodo);
      await _navigationService.back();
    } catch (e) {
      setError('Failed to update todo. Please try again.');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
