import 'package:app_template/domain/core/app_error.dart';
import 'package:equatable/equatable.dart';

enum ProductScreenStatus {
  initial,
  loading,
  ready,
  failure;

  bool get isLoading => this == ProductScreenStatus.loading;
}

class ProductScreenState extends Equatable {
  final ProductScreenStatus status;
  final AppError? error;

  const ProductScreenState({
    this.status = ProductScreenStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [status, error];

  ProductScreenState copyWith({ProductScreenStatus? status, AppError? error}) {
    return ProductScreenState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  ProductScreenState loading() {
    return copyWith(status: ProductScreenStatus.loading);
  }

  ProductScreenState ready() {
    return copyWith(status: ProductScreenStatus.ready);
  }

  ProductScreenState failure(AppError error) {
    return copyWith(status: ProductScreenStatus.failure, error: error);
  }
}
