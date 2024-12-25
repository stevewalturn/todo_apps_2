import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_apps_2/ui/common/app_colors.dart';
import 'package:todo_apps_2/ui/common/ui_helpers.dart';
import 'package:todo_apps_2/ui/widgets/todo_item.dart';
import 'package:todo_apps_2/ui/views/home/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: viewModel.hasError
          ? Center(
              child: Text(
                viewModel.modelError.toString(),
                style: const TextStyle(color: kcErrorColor),
              ),
            )
          : viewModel.todos.isEmpty
              ? const Center(
                  child: Text('No todos yet. Add one by tapping the + button!'),
                )
              : ListView.builder(
                  itemCount: viewModel.todos.length,
                  itemBuilder: (context, index) {
                    final todo = viewModel.todos[index];
                    return TodoItem(
                      todo: todo,
                      onToggle: () => viewModel.toggleTodoComplete(todo.id),
                      onEdit: () => viewModel.navigateToEditTodo(todo.id),
                      onDelete: () => viewModel.deleteTodo(todo.id),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.navigateToCreateTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
