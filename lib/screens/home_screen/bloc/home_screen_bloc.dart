import 'package:bloc/bloc.dart';
import 'package:libary_messaging_system/common/models/department_model.dart';
import 'package:libary_messaging_system/screens/home_screen/bloc/home_screen_event.dart';
import 'package:libary_messaging_system/screens/home_screen/bloc/home_screen_state.dart';
import 'package:libary_messaging_system/screens/home_screen/repository/home_screen_repository.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc({required HomeScreenState initialState})
      : super(initialState) {
    on<GetAllDepartmentsEvent>(_processGetAllDepartments);
  }

  _processGetAllDepartments(
    GetAllDepartmentsEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    try {
      List<DepartmentModel> departments =
          await HomeScreenRepository.getAllDepartments();

      emit(HomeScreenState.loaded(departments));
    } catch (e) {
      print('GET DEPARTMENTS ERROR: ${e.toString()}');
      emit(HomeScreenState.error(e.toString()));
    }
  }
}
