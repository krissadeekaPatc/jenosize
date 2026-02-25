import 'package:jenosize/ui/screens/main/main_screen_tab.dart';
import 'package:equatable/equatable.dart';

class MainScreenState extends Equatable {
  final MainScreenTab selectedTab;

  const MainScreenState({this.selectedTab = MainScreenTab.home});

  @override
  List<Object> get props => [selectedTab];

  MainScreenState copyWith({MainScreenTab? selectedTab}) {
    return MainScreenState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}
