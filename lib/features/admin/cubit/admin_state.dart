// import 'package:e_fashion_flutter/core/enums/request_status.dart';
// import 'package:e_fashion_flutter/features/admin/data/chat_model.dart';
// import 'package:equatable/equatable.dart';
//
// class AdminState extends Equatable {
//   final List<ChatModel> chats;
//
//   final RequestStatus getAllChatsState;
//   final String errorMessage;
//
//   const AdminState({
//     this.getAllChatsState = RequestStatus.initial,
//     this.errorMessage = '',
//     this.chats = const [],
//   });
//
//   AdminState copyWith({
//     RequestStatus? getAllChatsState,
//     String? errorMessage,
//     List<ChatModel>? chats,
//   }) {
//     return AdminState(
//       getAllChatsState: getAllChatsState ?? this.getAllChatsState,
//       errorMessage: errorMessage ?? this.errorMessage,
//       chats: chats ?? this.chats,
//     );
//   }
//
//   @override
//   List<Object> get props => [getAllChatsState, errorMessage, chats];
// }
