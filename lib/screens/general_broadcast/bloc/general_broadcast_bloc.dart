import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:libary_messaging_system/screens/general_broadcast/broadcast_model.dart';
import 'package:meta/meta.dart';

import '../repository/general_broadcast_repository.dart';

part 'general_broadcast_event.dart';
part 'general_broadcast_state.dart';

class GeneralBroadcastBloc
    extends Bloc<GeneralBroadcastEvent, GeneralBroadcastState> {
  GeneralBroadcastBloc({required GeneralBroadcastState initialState})
      : super(GeneralBroadcastState.loading()) {
    on<GetBroadcastEvent>(_processGeneralBroadcastEvent);
  }
}

_processGeneralBroadcastEvent(
    GetBroadcastEvent event, Emitter<GeneralBroadcastState> emit) async {
  try {
    List<GeneralBroadcastModel> generalBroadcastModelList =
        await GeneralBroadcastRepository.getDepartmentBroadcast(
            departmentId: event.departmentId);

    emit(GeneralBroadcastState.loaded(generalBroadcastModelList));
  } catch (e) {
    print('GET BROADCAST ERROR ::: ${e.toString()}');
    emit(GeneralBroadcastState.error(e.toString()));
  }
}
