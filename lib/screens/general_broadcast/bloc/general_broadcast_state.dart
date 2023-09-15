part of 'general_broadcast_bloc.dart';

enum GeneralBroadcastStatus { unknown, error, loading, loaded }

class GeneralBroadcastState extends Equatable {
  final String? error;
  final List<GeneralBroadcastModel>? generalBroadcastModelList;
  final GeneralBroadcastStatus status;

  GeneralBroadcastState(this.status,
      {this.error, this.generalBroadcastModelList});

  GeneralBroadcastState.unknown() : this(GeneralBroadcastStatus.unknown);
  GeneralBroadcastState.loading() : this(GeneralBroadcastStatus.loading);
  GeneralBroadcastState.error(String error)
      : this(GeneralBroadcastStatus.error, error: error);
  GeneralBroadcastState.loaded(
      List<GeneralBroadcastModel> generalBroadcastModelList)
      : this(GeneralBroadcastStatus.loaded,
            generalBroadcastModelList: generalBroadcastModelList);

  @override
  List<Object?> get props => [error, status, generalBroadcastModelList];
}
