import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/admin/cubit/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AllChatsScreen extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    lazy: false,
    create: (context) => getIt<AdminCubit>()..getAllChats(),
    child: this,
  );

  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
