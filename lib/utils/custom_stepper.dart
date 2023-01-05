import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  final int lowerLimit;
  final int upperLimit;
  final int quantity;
  final int stepValue;
  final double iconSize;
  final Function? onRemove;
  final ValueChanged<dynamic> onChanged;

  const CustomStepper({
    super.key,
    required this.lowerLimit,
    required this.upperLimit,
    required this.stepValue,
    required this.iconSize,
    required this.onChanged,
    required this.quantity,
    this.onRemove,
  });

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  late int value;

  @override
  void initState() {
    value = widget.quantity;
    super.initState();
  }

  _remove() {
    if (value > widget.lowerLimit) setState(() => widget.onChanged(--value));
    if (widget.onRemove != null && value == widget.lowerLimit) widget.onRemove!();
  }

  _add() {
    if (value < widget.upperLimit) setState(() => widget.onChanged(++value));
  }

  @override
  Widget build(BuildContext context) {
    IconData removeIcon = (widget.onRemove != null && value <= widget.lowerLimit) ? Icons.delete : Icons.remove;

    return Container(
      height: 18 + widget.iconSize,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 15, spreadRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: Icon(removeIcon, size: widget.iconSize), splashRadius: 20, onPressed: _remove),
          SizedBox(
            width: widget.iconSize,
            child: Text("$value", textAlign: TextAlign.center, style: TextStyle(fontSize: widget.iconSize * 0.8)),
          ),
          IconButton(icon: Icon(Icons.add, size: widget.iconSize), splashRadius: 20, onPressed: _add),
        ],
      ),
    );
  }
}
