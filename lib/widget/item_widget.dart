import 'package:flutter/material.dart';
import 'package:mobile_assignment_fib_num/bloc/fibonacci_bloc.dart';

class ItemWidget extends StatelessWidget {
  final int index;
  final String fibonacciNumber;
  final FiboanacciType type;
  final Function()? onTap;
  final bool? selected;
  final Color? color;
  const ItemWidget(
      {super.key,
      required this.index,
      required this.fibonacciNumber,
      required this.type,
      this.selected,
      this.color,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: kToolbarHeight,
      onTap: onTap,
      selectedTileColor: color?? Colors.green,
      selected: selected ?? false,
      selectedColor: Colors.white,
      title: Text(
        'index: $index ,Number: $fibonacciNumber',
      ),
      trailing: iconType(),
    );
  }

  Icon iconType() {
    switch (type) {
      case FiboanacciType.circle:
        return Icon(Icons.circle);
      case FiboanacciType.cross:
        return Icon(Icons.close);
      case FiboanacciType.square:
        return Icon(Icons.square_outlined);
    }
  }
}
