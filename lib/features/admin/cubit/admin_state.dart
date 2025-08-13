import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:equatable/equatable.dart';

class AdminState extends Equatable {
  final RequestStatus getAllChatsState;
  final String errorMessage;

  const AdminState({
    this.getAllChatsState = RequestStatus.initial,
    this.errorMessage = '',
  });

  AdminState copyWith({RequestStatus? getAllChatsState, String? errorMessage}) {
    return AdminState(
      getAllChatsState: getAllChatsState ?? this.getAllChatsState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [getAllChatsState, errorMessage];
}
