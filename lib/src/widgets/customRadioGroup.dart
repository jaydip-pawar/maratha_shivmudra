import 'package:flutter/material.dart';

class CustomRadioGroup extends StatefulWidget {
  final List<String> labels;
  final Axis alignment;
  final int? maxItems;
  final TextStyle? textStyle;
  final String? initialValue;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final void Function(String)? onChanged; // Updated callback type

  CustomRadioGroup({
    required this.labels,
    this.alignment = Axis.vertical,
    this.maxItems,
    this.textStyle,
    this.initialValue,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.onChanged,
  });

  @override
  _CustomRadioGroupState createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _onChanged(String? value) {
    setState(() {
      _selectedValue = value;
      widget.onChanged?.call(_selectedValue ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment == Axis.vertical
        ? Column(
            mainAxisSize: widget.mainAxisSize,
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            spacing: 8,
            children: _buildRadioList(),
          )
        : Wrap(
            children: _buildHorizontalWrap(),
          );
  }

  List<Widget> _buildRadioList() {
    return widget.labels
        .map(
          (label) => RadioTile(
            label: label,
            textStyle: widget.textStyle,
            groupValue: _selectedValue,
            onChanged: _onChanged,
          ),
        )
        .toList();
  }

  List<Widget> _buildHorizontalWrap() {
    List<Widget> radioTiles = [];
    for (int i = 0; i < widget.labels.length; i++) {
      if (widget.maxItems != null && i != 0 && i % widget.maxItems! == 0) {
        radioTiles.add(SizedBox(width: double.infinity)); // New line
      }
      radioTiles.add(
        RadioTile(
          label: widget.labels[i],
          textStyle: widget.textStyle,
          groupValue: _selectedValue,
          onChanged: _onChanged,
        ),
      );
    }
    return radioTiles;
  }
}

class RadioTile extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;
  final String? groupValue;
  final ValueChanged<String?>? onChanged;

  RadioTile({
    required this.label,
    this.textStyle,
    this.groupValue,
    this.onChanged,
  });

  void _handleTap() {
    if (onChanged != null) {
      onChanged!(label);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Radio<String?>(
            value: label,
            groupValue: groupValue,
            onChanged: onChanged,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
