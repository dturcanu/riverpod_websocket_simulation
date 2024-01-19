import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_websocket_simulation/main.dart';

class AddCounterPage extends ConsumerWidget {
  const AddCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter page"),
        actions: [
          IconButton(
              onPressed: () {
                ref.invalidate(counterProvider);
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
          child: Text(
        '',
        style: Theme.of(context).textTheme.displayMedium,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
