import 'package:jenosize/ui/screens/main/cubit/main_screen_state.dart';
import 'package:jenosize/ui/screens/main/main_screen_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(const MainScreenState());

  void changeTab(MainScreenTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
}
