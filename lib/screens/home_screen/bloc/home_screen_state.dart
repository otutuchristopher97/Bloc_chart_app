import 'package:equatable/equatable.dart';

import '../../../common/models/department_model.dart';

enum HomeScreenStatus { error, loading, loaded }

class HomeScreenState extends Equatable {
  final String? error;
  final List<DepartmentModel>? departments;
  final HomeScreenStatus status;
  const HomeScreenState({this.error, this.departments, required this.status});

  @override
  List<Object?> get props => [error, status, departments];

  const HomeScreenState.error(String error)
      : this(error: error, status: HomeScreenStatus.error);
  const HomeScreenState.loaded(List<DepartmentModel> allDepartments)
      : this(departments: allDepartments, status: HomeScreenStatus.loaded);
  const HomeScreenState.loading() : this(status: HomeScreenStatus.loading);
}
