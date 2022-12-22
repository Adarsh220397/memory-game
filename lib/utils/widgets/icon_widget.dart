import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  final IconData iconData;
  double? size;
  Color? color;
  IconWidget({super.key, this.size, this.color, required this.iconData});

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.iconData,
      size: widget.size,
      color: widget.color,
    );
  }
}
