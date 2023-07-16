import 'package:charity/modules/auth/module/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: add logout button (to all pages?)
class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userNotifierProvider, (_, newUser) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        'category',
        (Route<dynamic> route) => false,
      );
    });

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(),
              const Icon(
                Icons.credit_card,
                size: 50,
                color: Colors.black,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Aproxime sua tag do leitor',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
