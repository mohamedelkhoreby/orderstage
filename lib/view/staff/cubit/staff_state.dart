part of 'staff_cubit.dart';
abstract class StaffState extends Equatable {
  @override
  List<Object?> get props => [];
}
class StaffInitial extends StaffState {}

class StaffLoading extends StaffState {}

class StaffLoaded extends StaffState {
  final List<User> users;

  StaffLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class StaffError extends StaffState {
  final String message;

  StaffError(this.message);

  @override
  List<Object?> get props => [message];
}

