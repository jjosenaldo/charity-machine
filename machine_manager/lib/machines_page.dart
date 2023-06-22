import 'package:flutter/material.dart';
import 'package:machine_manager/machine_page.dart';

class MachinesPage extends StatelessWidget {
  const MachinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Máquinas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemBuilder: (context, index) => [
            _Machine(
              name: 'Máquina do Midway',
              address: 'Av. Nevaldo Rocha, 3775 - Tirol, Natal - RN, 59015-450',
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => MachinePage())),
            ),
            _Machine(
              name: 'Máquina da Av. 1',
              address:
                  'Alecrim, Natal - State of Rio Grande do Norte, 59031-150',
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => MachinePage())),
            ),
            _Machine(
              name: 'Máquina XYZ',
              address:
                  'Av. Engenheiro Roberto Freire, 3132 - Capim Macio, Natal - RN, 59082-400',
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => MachinePage())),
            ),
          ][index],
          separatorBuilder: (_, __) => Divider(),
          itemCount: 3,
        ),
      ),
    );
  }
}

class _Machine extends StatelessWidget {
  const _Machine({
    super.key,
    required this.name,
    required this.address,
    required this.onPressed,
  });

  final String name;
  final String address;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 16,
                      ),
                      SizedBox(width: 4.0),
                      Expanded(child: Text(address))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.black,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
