import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends HookWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final key = useState(UniqueKey());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: AnimatedGridView(key: key.value),
      floatingActionButton: FloatingActionButton(
        onPressed: () => key.value = UniqueKey(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AnimatedGridView extends HookWidget {
  const AnimatedGridView({super.key});

  double _calculateDistance(int row, int col) => sqrt(row * row + col * col);

  @override
  Widget build(BuildContext context) {
    const int totalItems = 300;
    const int rowsCount = 5;

    final shouldStartAnimation = useState(false);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        shouldStartAnimation.value = true;
      });
      return null;
    }, []);

    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rowsCount,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        int col = index ~/ rowsCount;
        int row = index % rowsCount;
        double distance = _calculateDistance(row, col);
        return GridItem(
          row: row,
          col: col,
          index: index,
          delay: Duration(milliseconds: (60 * distance).toInt()),
          shouldAnimate: shouldStartAnimation.value,
          distance: distance,
        );
      },
      itemCount: totalItems,
    );
  }
}

class GridItem extends HookWidget {
  final int row;
  final int col;
  final int index;
  final Duration delay;
  final bool shouldAnimate;
  final double distance;

  const GridItem({
    super.key,
    required this.row,
    required this.col,
    required this.index,
    required this.delay,
    required this.shouldAnimate,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    final isVisible = useState(false);

    useEffect(() {
      if (shouldAnimate) {
        isVisible.value = true;
      }
      Future.delayed(delay, () {
        isVisible.value = true;
      });
      return null;
    }, []);

    return AnimatedOpacity(
      opacity: isVisible.value ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        margin: const EdgeInsets.all(4),
        color: Colors.primaries[index % Colors.primaries.length],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Index: $index',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              'Position: ($row, $col)',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 2),
            Text(
              'Delay: ${delay.inMilliseconds}ms',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              'Distance: ${distance.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
