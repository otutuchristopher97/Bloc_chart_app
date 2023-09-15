enum AddBroadcastStatus { unknown, loading, done, error }

class AddBroadCastState {
  final String? error;
  final AddBroadcastStatus status;

  AddBroadCastState({required this.status, this.error});

  AddBroadCastState.done() : this(status: AddBroadcastStatus.done);
  AddBroadCastState.unknown() : this(status: AddBroadcastStatus.unknown);
  AddBroadCastState.loading() : this(status: AddBroadcastStatus.loading);
  AddBroadCastState.error(String error)
      : this(status: AddBroadcastStatus.error, error: error);
}
