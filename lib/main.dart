import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/foodlistbloc_bloc.dart';
import 'model/item_count_model.dart';
import 'repository/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter task'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentItemCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodlistBloc(
        repository: context.read<Repository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return FoodList(
                  title: context
                      .watch<FoodlistBloc>()
                      .repository
                      .foodList[index]
                      .title,
                  subtitle: context
                      .watch<FoodlistBloc>()
                      .repository
                      .foodList[index]
                      .subtitle,
                  price: context
                      .watch<FoodlistBloc>()
                      .repository
                      .foodList[index]
                      .price,
                  itemCount: context
                      .watch<FoodlistBloc>()
                      .repository
                      .foodList[index]
                      .itemCount,
                  index: index,
                );
              },
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<FoodlistBloc, FoodlistState>(
                builder: (context, state) {
                  if (state is AddItemState) {
                    return Text('${state.currentItemCount} items');
                  } else if (state is RemoveItemState) {
                    return Text('${state.currentItemCount} items');
                  } else {
                    return const Text('0');
                  }
                },
              ),
              MaterialButton(
                color: Colors.green,
                child: const Text('Place order'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FoodList extends StatelessWidget {
  const FoodList({
    Key? key,
    required String title,
    required String subtitle,
    required String price,
    required int itemCount,
    required int index,
  })  : _title = title,
        _subtitle = subtitle,
        _price = price,
        _itemCount = itemCount,
        _index = index,
        super(key: key);

  final String _title;
  final String _subtitle;
  final String _price;
  final int _itemCount;
  final int _index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            color: Colors.black12,
            height: 100,
            width: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_title),
              Text(_subtitle),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.join_left_sharp),
                      Text(_price),
                    ],
                  ),
                  Row(children: [
                    MaterialButton(
                      minWidth: 10,
                      height: 20,
                      color: Colors.green,
                      onPressed: () {
                        BlocProvider.of<FoodlistBloc>(context)
                            .add(AddItemEvent(ItemCount(_title, _itemCount)));
                        context
                            .read<FoodlistBloc>()
                            .repository
                            .specificItemAddUpdate(_index);
                      },
                      child: const Icon(Icons.add),
                    ),
                    BlocBuilder<FoodlistBloc, FoodlistState>(
                      builder: (context, state) {
                        if (state is AddItemState) {
                          return Text(
                              '${state.specificItemCount[_index].itemCount}');
                        } else if (state is RemoveItemState) {
                          return Text(
                              '${state.specificItemCount[_index].itemCount} items');
                        } else {
                          return const Text('0');
                        }
                      },
                    ),
                    MaterialButton(
                      minWidth: 10,
                      height: 20,
                      color: Colors.green,
                      onPressed: () {
                        BlocProvider.of<FoodlistBloc>(context).add(
                            RemoveItemEvent(ItemCount(_title, _itemCount)));
                        context
                            .read<FoodlistBloc>()
                            .repository
                            .specificItemSubractUpdate(_index);
                      },
                      child: const Icon(Icons.delete),
                    ),
                  ]),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
