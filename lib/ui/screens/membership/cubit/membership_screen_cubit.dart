import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/repositories/point_repository.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/screens/membership/cubit/membership_screen_state.dart';

class MembershipScreenCubit extends Cubit<MembershipScreenState> {
  final SessionCubit sessionCubit;
  final PointRepository pointRepository;

  MembershipScreenCubit({
    required this.sessionCubit,
    required this.pointRepository,
  }) : super(const MembershipScreenState());

  Future<void> joinMembership() async {
    final currentUser = sessionCubit.state.user;
    if (currentUser == null || currentUser.id == null) return;

    emit(state.loading());

    const welcomePoints = 100;
    const transactionTitle = 'Welcome Bonus';

    final result = await pointRepository.addTransaction(
      userId: currentUser.id!,
      title: transactionTitle,
      points: welcomePoints,
    );

    switch (result) {
      case Success():
        final updatedUser = User(
          id: currentUser.id,
          firstName: currentUser.firstName,
          lastName: currentUser.lastName,
          email: currentUser.email,
          gender: currentUser.gender,
          totalPoints: (currentUser.totalPoints ?? 0) + welcomePoints,
          isMember: true,
        );
        sessionCubit.setUser(updatedUser);
        emit(state.ready());
      case Failure(:final error):
        emit(state.failure(error));
    }
  }
}
