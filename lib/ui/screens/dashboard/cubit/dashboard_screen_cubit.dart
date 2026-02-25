import 'package:app_template/ui/screens/dashboard/cubit/dashboard_screen_state.dart';
import 'package:app_template/ui/screens/dashboard/dashboard_screen_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreenCubit extends Cubit<DashboardScreenState> {
  DashboardScreenCubit() : super(const DashboardScreenState());

  void setSelectedTab(DashboardScreenTab newTab) {
    emit(state.copyWith(selectedTab: newTab));
  }
}
