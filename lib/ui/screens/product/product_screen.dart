import 'package:app_template/ui/screens/product/cubit/product_screen_cubit.dart';
import 'package:app_template/ui/screens/product/cubit/product_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  final String? productId;

  const ProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductScreenCubit(productId: productId),
      child: const ProductScreenView(),
    );
  }
}

class ProductScreenView extends StatefulWidget {
  const ProductScreenView({super.key});

  @override
  State<ProductScreenView> createState() => _ProductScreenViewState();
}

class _ProductScreenViewState extends State<ProductScreenView> {
  late final ProductScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProductScreenCubit>();
  }

  void _listener(BuildContext context, ProductScreenState state) {
    switch (state.status) {
      case ProductScreenStatus.initial:
      case ProductScreenStatus.loading:
      case ProductScreenStatus.ready:
        break;

      case ProductScreenStatus.failure:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductScreenCubit, ProductScreenState>(
      listener: _listener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Product Screen'), centerTitle: true),
        body: Center(child: Text('id: ${_cubit.productId}')),
      ),
    );
  }
}
