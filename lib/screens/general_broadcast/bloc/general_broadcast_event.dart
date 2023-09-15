part of 'general_broadcast_bloc.dart';

@immutable
abstract class GeneralBroadcastEvent {}

class GetBroadcastEvent extends GeneralBroadcastEvent {
  final String departmentId;
  GetBroadcastEvent({required this.departmentId});
}
