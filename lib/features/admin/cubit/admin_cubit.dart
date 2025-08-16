import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/admin/admin_repo/admin_repo.dart';
import 'package:e_fashion_flutter/features/admin/cubit/admin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepo adminRepo;

  AdminCubit({required this.adminRepo}) : super(const AdminState());

  Future<void> getAllChats() async {
    emit(state.copyWith(getAllChatsState: RequestStatus.loading));
    final either = await adminRepo.getAllChats();
    either.fold(
      (failure) {
        emit(
          state.copyWith(
            getAllChatsState: RequestStatus.error,
            errorMessage: failure.errorMessage,
          ),
        );
      },
      (chats) {
        emit(
          state.copyWith(getAllChatsState: RequestStatus.success, chats: chats),
        );
      },
    );
  }
}
