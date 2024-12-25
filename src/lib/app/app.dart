import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_apps_2/services/todo_service.dart';
import 'package:todo_apps_2/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:todo_apps_2/ui/dialogs/confirm_delete/confirm_delete_dialog.dart';
import 'package:todo_apps_2/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:todo_apps_2/ui/views/home/home_view.dart';
import 'package:todo_apps_2/ui/views/startup/startup_view.dart';
import 'package:todo_apps_2/ui/views/todo/create_todo_view.dart';
import 'package:todo_apps_2/ui/views/todo/edit_todo_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: CreateTodoView),
    MaterialRoute(page: EditTodoView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TodoService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ConfirmDeleteDialog),
  ],
)
class App {}
