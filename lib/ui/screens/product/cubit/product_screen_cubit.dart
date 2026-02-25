import 'package:app_template/ui/screens/product/cubit/product_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreenCubit extends Cubit<ProductScreenState> {
  final String? productId;

  ProductScreenCubit({required this.productId})
    : super(const ProductScreenState());
}
