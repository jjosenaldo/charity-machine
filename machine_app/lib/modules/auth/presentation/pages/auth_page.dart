import 'package:flutter/material.dart';

// TODO: add logout button (to all pages?)
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('category'),
                // TODO: remove after
                child: const Text('DEV: fingir leitura de cartão'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
