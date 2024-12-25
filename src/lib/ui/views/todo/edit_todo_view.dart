import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_apps_2/ui/common/app_colors.dart';
import 'package:todo_apps_2/ui/views/todo/edit_todo_viewmodel.dart';
import 'package:todo_apps_2/ui/widgets/todo_form.dart';

class EditTodoView extends StackedView<EditTodoViewModel> {
  final String todoId;

  const EditTodoView({
    required this.todoId,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    EditTodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      body: Column(
        children: [
          if (viewModel.hasError)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                viewModel.modelError.toString(),
                style: const TextStyle(color: kcErrorColor),
              ),
            ),
          Expanded(
            child: TodoForm(
              titleController: viewModel.titleController,
              descriptionController: viewModel.descriptionController,
              titleError: viewModel.titleError,
              descriptionError: viewModel.descriptionError,
              onSave: viewModel.updateTodo,
              submitButtonText: 'Update Todo',
            ),
          ),
        ],
      ),
    );
  }

  @override
  EditTodoViewModel viewModelBuilder(BuildContext context) =>
      EditTodoViewModel();

  @override
  void onViewModelReady(EditTodoViewModel viewModel) => viewModel.init(todoId);
}
