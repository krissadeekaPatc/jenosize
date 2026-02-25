import 'package:app_template/ui/screens/home/cubit/home_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenState());

  void showLoading500ms() async {
    emit(state.loading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.ready());
  }
}
