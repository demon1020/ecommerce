import 'package:ecommerce/core/data/repositories/hive_service.dart';
import 'package:ecommerce/features/home/domain/use_cases/product_use_case.dart';
import 'package:provider/single_child_widget.dart';

import '../core.dart';
import '../features/add_product/presentation/manager/add_product_bloc.dart';
import '../features/checkout/presentation/manager/checkout_bloc.dart';
import '../features/home/presentation/manager/home_bloc.dart';
import '../features/profile/presentation/manager/profile_bloc.dart';

class Providers {
  static List<SingleChildWidget> getAllProviders() {
    return [
      // BlocProvider(create: (context) => LoginBloc(sl<LoginUseCase>())),
      BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(sl<ProductUseCase>())),
      BlocProvider<AddProductBloc>(create: (context) => AddProductBloc()),
      BlocProvider<CheckoutBloc>(
          create: (context) => CheckoutBloc(HiveService())),
      BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
    ];
  }
}
