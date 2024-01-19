import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_websocket_simulation/pages/add_counter_page%20copy.dart';
import 'package:riverpod_websocket_simulation/pages/remove_counter_page.dart';

abstract class WebsocketClient {
  Stream<int> getCounterStream([int startValue]);
}

class FakeWebsocketClient implements WebsocketClient {
  @override
  Stream<int> getCounterStream([int startValue = 0]) async* {
    int i = startValue;
    await Future.delayed(const Duration(seconds: 3));
    while (i != 10) {
      await Future.delayed(const Duration(seconds: 1));
      yield ++i;
    }
    throw Exception("errore ciclo concluso");
  }
}

final websocketClientProvider = Provider<WebsocketClient>((ref) {
  return FakeWebsocketClient();
});

final counterProvider = StreamProvider.family<int, int>((ref, startValue) {
  final wsClient = ref.watch(websocketClientProvider);
  return wsClient.getCounterStream(startValue);
});

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int customStartValue = 5;
    final AsyncValue<int> counter =
        ref.watch(counterProvider(customStartValue));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Actual value',
            ),
            Text(
              counter
                  .when(
                      data: (int value) => value,
                      error: (Object e, _) => e,
                      loading: () => "Loading for 3 seconds...")
                  .toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddCounterPage(),
                  ));
                },
                child: const Text("Go to Add Page")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RemoveCounterPage(),
                  ));
                },
                child: const Text("Go to Remove Page")),
          ],
        ),
      ),
    );
  }
}
