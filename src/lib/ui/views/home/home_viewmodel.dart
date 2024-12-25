import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps_2/app/app.locator.dart';
import 'package:todo_apps_2/app/app.router.dart';
import 'package:todo_apps_2/models/todo.dart';
import 'package:todo_apps_2/services/todo_service.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  List<Todo> get todos => _todoService.todos;

  Future<void> navigateToCreateTodo() async {
    try {
      await _navigationService.navigateToCreateTodoView();
      rebuildUi();
    } catch (e) {
      setError('Unable to navigate to create todo screen');
    }
  }

  Future<void> navigateToEditTodo(String id) async {
    try {
      await _navigationService.navigateToEditTodoView(todoId: id);
      rebuildUi();
    } catch (e) {
      setError('Unable to navigate to edit todo screen');
    }
  }

  Future<void> toggleTodoComplete(String id) async {
    try {
      _todoService.toggleTodoComplete(id);
      rebuildUi();
    } catch (e) {
      setError('Unable to update todo status');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      final response = await _dialogService.showCustomDialog(
        variant: DialogType.confirmDelete,
        title: 'Delete Todo',
        description: 'Are you sure you want to delete this todo?',
      );

      if (response?.confirmed ?? false) {
        _todoService.deleteTodo(id);
        rebuildUi();
      }
    } catch (e) {
      setError('Unable to delete todo');
    }
  }
}
