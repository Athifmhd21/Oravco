import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/core/features/homescreen/home_viewmodel.dart';
import 'package:ecommerce/core/features/productscreen/productScreen.dart';
import 'package:ecommerce/core/widgets/card.dart';
import 'package:ecommerce/core/themepro.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await context.read<HomeViewModel>().getProducts();
      await context.read<HomeViewModel>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      floatingActionButton: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return FloatingActionButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            child: Icon(
              themeProvider.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
          );
        },
      ),

      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Text(
                    "Products",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: viewModel.products.length,
                      itemBuilder: (context, index) {
                        final product = viewModel.products[index];

                        return ProductCard(
                          image: product.image,
                          title: product.title,
                          description: product.description,
                          price: product.price,
                          isFavorite: viewModel.isFavorite(product.id),
                          onFavoriteTap: () {
                            viewModel.toggleFavorite(product.id);
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailsScreen(product: product),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
