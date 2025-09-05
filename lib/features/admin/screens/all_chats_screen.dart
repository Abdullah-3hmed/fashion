// import 'package:auto_route/auto_route.dart';
// import 'package:e_fashion_flutter/config/router/app_router.dart';
// import 'package:e_fashion_flutter/core/enums/request_status.dart';
// import 'package:e_fashion_flutter/core/services/service_locator.dart';
// import 'package:e_fashion_flutter/features/admin/cubit/admin_cubit.dart';
// import 'package:e_fashion_flutter/features/admin/cubit/admin_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// @RoutePage()
// class AllChatsScreen extends StatelessWidget implements AutoRouteWrapper {
//   @override
//   Widget wrappedRoute(BuildContext context) => BlocProvider(
//     lazy: false,
//     create: (context) => getIt<AdminCubit>()..getAllChats(),
//     child: this,
//   );
//
//   const AllChatsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: BlocBuilder<AdminCubit, AdminState>(
//         builder: (context, state) {
//           switch (state.getAllChatsState) {
//             case RequestStatus.loading:
//               return const Center(child: CircularProgressIndicator());
//             case RequestStatus.success:
//               return Padding(
//                 padding: const EdgeInsetsDirectional.symmetric(
//                   horizontal: 16.0,
//                 ),
//                 child: ListView.separated(
//                   itemBuilder:
//                       (context, index) => InkWell(
//                         onTap: () {
//                           context.pushRoute( ChatSupportRoute(receiverId: state.chats[index].senderId));
//                         },
//                         child: ListTile(
//                           title: Text(
//                             state.chats[index].userName,
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                           subtitle: Text(
//                             state.chats[index].lastMessage,
//                             style: Theme.of(context).textTheme.bodyMedium,
//                           ),
//                         ),
//                       ),
//                   separatorBuilder: (_, _) => const SizedBox(height: 16.0),
//                   itemCount: state.chats.length,
//                 ),
//               );
//             case RequestStatus.error:
//               return Center(child: Text(state.errorMessage));
//             default:
//               return const SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
// }
