import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_apps_2/ui/common/app_colors.dart';
import 'package:todo_apps_2/ui/views/todo/create_todo_viewmodel.dart';
import 'package:todo_apps_2/ui/widgets/todo_form.dart';

class CreateTodoView extends StackedView<CreateTodoViewModel> {
  const CreateTodoView({super.key});

  @override
  Widget builder(
    BuildContext context,
    CreateTodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todo'),
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
              onSave: viewModel.saveTodo,
              submitButtonText: 'Create Todo',
            ),
          ),
        ],
      ),
    );
  }

  @override
  CreateTodoViewModel viewModelBuilder(BuildContext context) =>
      CreateTodoViewModel();
}
