import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/features/profile/cubit/order_cubit/order_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/order_cubit/order_state.dart';
import 'package:e_fashion_flutter/features/profile/data/order/order_model.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/no_orders_yet.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class OrderStatusScreen extends StatelessWidget implements AutoRouteWrapper {
  const OrderStatusScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    create: (context) => getIt<OrderCubit>()..getOrders(),
    child: this,
  );
  static List<OrderModel> dummyOrderList = List.generate(
    5,
    (index) => const OrderModel(orderId: 12146541, orderPrice: 123),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Status',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocConsumer<OrderCubit, OrderState>(
        listenWhen: (prev, curr) => prev.orderState != curr.orderState,
        listener: (context, state) {
          if (state.orderState.isError) {
            showToast(
              message: state.orderErrorMessage,
              state: ToastStates.error,
            );
          }
        },
        buildWhen: (prev, curr) => prev.orderState != curr.orderState,
        builder: (context, state) {
          switch (state.orderState) {
            case RequestStatus.loading:
              return Skeletonizer(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder:
                      (context, index) =>
                          OrderItem(order: dummyOrderList[index]),
                  itemCount: dummyOrderList.length,
                ),
              );
            case RequestStatus.success:
              return state.orders.isEmpty
                  ? const NoOrdersYet()
                  : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder:
                        (context, index) =>
                            OrderItem(order: state.orders[index]),
                    itemCount: state.orders.length,
                  );
            case RequestStatus.error:
              return Center(
                child: Text(
                  state.orderErrorMessage,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
