import 'package:charity/modules/common/presentation/charity_state.dart';
import 'package:charity/modules/home/domain/entities/home_data.dart';
import 'package:charity/modules/home/home_providers.dart';
import 'package:charity/modules/home/presentation/pages/select_category/components/category_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectCategoryPage extends ConsumerWidget {
  const SelectCategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeDataState = ref.watch(categoryMenuNotifierProvider);

    return Scaffold(
      body: switch (homeDataState) {
        Loading _ => const Center(
            child: CircularProgressIndicator(),
          ),
        Error _ => Container(), // TODO
        Success<HomeData> success => () {
            final categories = success.data.categories;

            if (categories.isEmpty) {
              return Container();
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  categories.length * 2 - 1,
                  (index) {
                    final category = categories[index ~/ 2];
                    return index.isEven
                        ? Expanded(
                            child: CategoryButton(
                              iconColor: Color(category.category.color),
                              imageUrl: category.imageUrl,
                              name: category.name,
                              onPressed: () => Navigator.of(context).pushNamed(
                                'item',
                                arguments: category.items,
                              ),
                            ),
                          )
                        : const SizedBox(height: 16.0);
                  },
                ),
              ),
            );
          }(),
      },
    );
  }
}
