import 'package:charity/modules/auth/presentation/pages/auth_page.dart';
import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/home/module/home_providers.dart';
import 'package:charity/modules/home/presentation/pages/select_category/select_category_page.dart';
import 'package:charity/modules/menu/menu_providers.dart';
import 'package:charity/modules/menu/presentation/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CharityApp extends StatelessWidget {
  const CharityApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return const ProviderScope(child: _CharityAppConsumer());
  }
}

class _CharityAppConsumer extends ConsumerWidget {
  const _CharityAppConsumer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: don't use hardcoded routes
    return MaterialApp(
      initialRoute: 'auth',
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      onGenerateRoute: (settings) {
        WidgetBuilder builder = (_) {
          debugPrint('black screen da morte com nome: ${settings.name}');
          return Container();
        };

        if (settings.name == 'auth') {
          builder = (_) => const AuthPage();
        } else if (settings.name == 'category') {
          builder = (_) {
            _runAfterBuild(
              ref.watch(categoryMenuNotifierProvider.notifier).loadMenu,
            );

            return const SelectCategoryPage();
          };
        } else if (settings.name == 'item') {
          builder = (_) {
            final items = (settings.arguments is List<Item>
                    ? settings.arguments as List<Item>
                    : <Item>[])
                .where((item) => item.isAvailable)
                .toList();

            _runAfterBuild(
              () => ref
                  .read(categoryItemsNotifierProvider.notifier)
                  .setItems(items),
            );

            return const MenuPage();
          };
        }

        return MaterialPageRoute(builder: builder);
      },
    );
  }
}

void _runAfterBuild(Function function) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => function(),
  );
}
