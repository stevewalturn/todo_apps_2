import 'package:stacked/stacked.dart';
import 'package:todo_apps_2/models/todo.dart';

class TodoService with ListenableServiceMixin {
  final List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  TodoService() {
    listenToReactiveValues([_todos]);
  }

  void addTodo(Todo todo) {
    try {
      _todos.add(todo);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add todo: ${e.toString()}');
    }
  }

  void updateTodo(Todo todo) {
    try {
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = todo;
        notifyListeners();
      } else {
        throw Exception('Todo not found');
      }
    } catch (e) {
      throw Exception('Failed to update todo: ${e.toString()}');
    }
  }

  void deleteTodo(String id) {
    try {
      _todos.removeWhere((todo) => todo.id == id);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete todo: ${e.toString()}');
    }
  }

  void toggleTodoComplete(String id) {
    try {
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        final todo = _todos[index];
        _todos[index] = todo.copyWith(
          isCompleted: !todo.isCompleted,
          completedAt: !todo.isCompleted ? DateTime.now() : null,
        );
        notifyListeners();
      } else {
        throw Exception('Todo not found');
      }
    } catch (e) {
      throw Exception('Failed to toggle todo completion: ${e.toString()}');
    }
  }

  Todo? getTodoById(String id) {
    try {
      return _todos.firstWhere((todo) => todo.id == id);
    } catch (e) {
      throw Exception('Todo not found');
    }
  }
}
