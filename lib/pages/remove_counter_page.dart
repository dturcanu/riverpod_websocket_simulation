import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoveCounterPage extends ConsumerWidget {
  const RemoveCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter page"),
      ),
      body: Center(
          child: Text(
        '',
        style: Theme.of(context).textTheme.displayMedium,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.remove),
      ),
    );
  }
}
