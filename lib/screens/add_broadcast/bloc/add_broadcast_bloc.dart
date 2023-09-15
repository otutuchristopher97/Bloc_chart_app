import 'package:bloc/bloc.dart';
import 'package:libary_messaging_system/screens/add_broadcast/bloc/add_broadcast_event.dart';
import 'package:libary_messaging_system/screens/add_broadcast/bloc/add_broadcast_state.dart';
import 'package:libary_messaging_system/screens/add_broadcast/repository/add_broadcast_repository.dart';

class AddBroadcastBloc extends Bloc<AddBroadcastEvent, AddBroadCastState> {
  AddBroadcastBloc({required AddBroadCastState initialState})
      : super(AddBroadCastState.unknown()) {
    on<AddBroadcastEvent>(_processAddBroadcastEvent);
  }
}

_processAddBroadcastEvent(
    AddBroadcastEvent event, Emitter<AddBroadCastState> emit) async {
  emit(AddBroadCastState.loading());
  try {
    await AddBroadcastRepository.sendBroadcast(
      userId: event.userId,
      broadcastMessage: event.broadcastMessage,
    );
    emit(AddBroadCastState.done());
  } catch (e) {
    emit(AddBroadCastState.error(e.toString()));
  }
}
