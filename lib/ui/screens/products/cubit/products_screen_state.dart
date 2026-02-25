import 'package:app_template/domain/core/app_error.dart';
import 'package:equatable/equatable.dart';

enum ProductsScreenStatus {
  initial,
  loading,
  ready,
  failure;

  bool get isLoading => this == ProductsScreenStatus.loading;
}

class ProductsScreenState extends Equatable {
  final ProductsScreenStatus status;
  final AppError? error;

  const ProductsScreenState({
    this.status = ProductsScreenStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [status, error];

  ProductsScreenState copyWith({
    ProductsScreenStatus? status,
    AppError? error,
  }) {
    return ProductsScreenState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  ProductsScreenState loading() {
    return copyWith(status: ProductsScreenStatus.loading);
  }

  ProductsScreenState ready() {
    return copyWith(status: ProductsScreenStatus.ready);
  }

  ProductsScreenState failure(AppError error) {
    return copyWith(status: ProductsScreenStatus.failure, error: error);
  }
}
