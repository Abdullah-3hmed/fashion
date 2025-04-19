import 'package:e_fashion_flutter/features/auth/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());
  void test() {
    debugPrint("test is working");
  }
}
