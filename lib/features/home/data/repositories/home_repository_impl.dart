import 'package:ecommerce/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:ecommerce/features/home/data/models/product_response_model.dart';
import 'package:ecommerce/features/home/domain/repositories/home_repository.dart';

import '../../../../core.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException, List<ProductResponseModel>>> fetchProductList(
      dynamic request) async {
    return await remoteDataSource.fetchProductList(request);
  }
}
