import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Notificações',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemBuilder: (context, index) => [
            ListTile(
              title: Text('Café da manhã acabando'),
              subtitle: Text(
                  'A máquina XYZ precisa de reposição de itens de café da manhã.'),
            ),
            ListTile(
              title: Text('Máquina com defeito'),
              subtitle: Text('Houve um problema técnico com a máquina XYZ.'),
            ),
            ListTile(
              title: Text('Itens sem lactose acabando'),
              subtitle: Text(
                  'A máquina XYZ precisa de reposição de itens sem lactose.'),
            ),
          ][index],
          separatorBuilder: (_, __) => Divider(),
          itemCount: 3,
        ),
      ),
    );
  }
}
