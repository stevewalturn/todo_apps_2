import 'package:todo_apps_2/main/bootstrap.dart';
import 'package:todo_apps_2/models/enums/flavor.dart';
import 'package:todo_apps_2/ui/views/app/app_view.dart';

void main() {
  bootstrap(
    builder: () => const AppView(),
    flavor: Flavor.development,
  );
}
