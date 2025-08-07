import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';

class SortButton extends StatefulWidget {
  const SortButton({super.key});

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return PopupMenuButton(
      child: IconButton(
        icon: SFIcon(
          _isSelected
              ? SFIcons.sf_ellipsis_circle
              : SFIcons.sf_ellipsis_circle_fill,
          fontSize: 24,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    );
  }
}
