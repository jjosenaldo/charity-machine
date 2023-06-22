import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MachinePage extends StatelessWidget {
  const MachinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Máquina do Midway',
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
            _ItemView(
              imageUrl:
                  'https://vejario.abril.com.br/wp-content/uploads/2017/09/felipe-fittipaldi12.jpg?quality=70&strip=info&w=1000&h=720&crop=1',
              name: 'Salada',
              diets: ['Vegano'],
              itemCount: 3,
            ),
            _ItemView(
              imageUrl:
                  'https://vejario.abril.com.br/wp-content/uploads/2017/09/felipe-fittipaldi12.jpg?quality=70&strip=info&w=1000&h=720&crop=1',
              name: 'Almoço',
              diets: [],
              itemCount: 1,
            ),
            _ItemView(
              imageUrl:
                  'https://vejario.abril.com.br/wp-content/uploads/2017/09/felipe-fittipaldi12.jpg?quality=70&strip=info&w=1000&h=720&crop=1',
              name: 'Macarronada',
              diets: ['Glúten, lactose'],
              itemCount: 4,
            ),
          ][index],
          separatorBuilder: (_, __) => Divider(),
          itemCount: 3,
        ),
      ),
    );
  }
}

class _ItemView extends StatelessWidget {
  const _ItemView({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.diets,
    required this.itemCount,
  });

  final String imageUrl;
  final String name;
  final List<String> diets;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        width: 100.0,
        height: 100.0,
        imageUrl: imageUrl,
      ),
      title: Text(name),
      subtitle: diets.isNotEmpty ? Text(diets.join(', ')) : null,
      trailing: _ItemCount(
        itemCount: itemCount,
      ),
    );
  }
}

class _ItemCount extends StatelessWidget {
  const _ItemCount({required this.itemCount});
  final int itemCount;
  final double size = 25.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Center(
        child: Text(
          itemCount.toString(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.5,
          ),
        ),
      ),
    );
  }
}
