import 'package:app_template/ui/screens/products/cubit/products_screen_cubit.dart';
import 'package:app_template/ui/screens/products/cubit/products_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsScreenCubit(),
      child: const ProductsScreenView(),
    );
  }
}

class ProductsScreenView extends StatefulWidget {
  const ProductsScreenView({super.key});

  @override
  State<ProductsScreenView> createState() => _ProductsScreenViewState();
}

class _ProductsScreenViewState extends State<ProductsScreenView> {
  void _listener(BuildContext context, ProductsScreenState state) {
    switch (state.status) {
      case ProductsScreenStatus.initial:
      case ProductsScreenStatus.loading:
      case ProductsScreenStatus.ready:
        break;

      case ProductsScreenStatus.failure:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsScreenCubit, ProductsScreenState>(
      listener: _listener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Products Screen'), centerTitle: true),
        body: const Center(child: Text('Products Screen')),
      ),
    );
  }
}
