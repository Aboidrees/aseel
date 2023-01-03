import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  final ValueChanged<dynamic> onChanged;

  const CustomStepper({
    super.key,
    required this.lowerLimit,
    required this.upperLimit,
    required this.stepValue,
    required this.iconSize,
    required this.onChanged,
  });

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  late int quantity;
  @override
  void initState() {
    quantity = widget.lowerLimit;
    super.initState();
  }

  _remove() {
    if (quantity > widget.lowerLimit) setState(() => widget.onChanged(--quantity));
  }

  _add() {
    if (quantity < widget.upperLimit) setState(() => widget.onChanged(++quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 15, spreadRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: const Icon(Icons.remove), splashRadius: 20, onPressed: _remove),
          SizedBox(
            width: widget.iconSize,
            child: Text("$quantity", textAlign: TextAlign.center, style: TextStyle(fontSize: widget.iconSize * 0.8)),
          ),
          IconButton(icon: const Icon(Icons.add), splashRadius: 20, onPressed: _add),
        ],
      ),
    );
  }
}
