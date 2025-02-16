import 'package:flutter/material.dart';
import 'package:mobile_assignment_fib_num/bloc/fibonacci_bloc.dart';

class ItemWidget extends StatelessWidget {
  final int index;
  final String fibonacciNumber;
  final FibonacciType type;
  final Function()? onTap;
  final bool? selected;
  final Color? color;
  final bool isOnBottomSheet;
  const ItemWidget(
      {super.key,
      required this.index,
      required this.fibonacciNumber,
      required this.type,
      this.selected,
      this.color,
      this.onTap,
      this.isOnBottomSheet = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: kToolbarHeight,
      onTap: onTap,
      selectedTileColor: color ?? Colors.green,
      selected: selected ?? false,
      selectedColor: Colors.white,
      title: Text(
        '${isOnBottomSheet ? '' : 'index: $index ,'}Number: $fibonacciNumber',
      ),
      subtitle: isOnBottomSheet ? Text('index: $index') : null,
      trailing: iconType(),
    );
  }

  Icon iconType() {
    switch (type) {
      case FibonacciType.circle:
        return Icon(Icons.circle);
      case FibonacciType.cross:
        return Icon(Icons.close);
      case FibonacciType.square:
        return Icon(Icons.square_outlined);
    }
  }
}
