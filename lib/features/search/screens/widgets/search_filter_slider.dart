import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SearchFilterSlider extends StatefulWidget {
  const SearchFilterSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
  });

  final ValueChanged<int> minValue;
  final ValueChanged<int> maxValue;

  @override
  State<SearchFilterSlider> createState() => _SearchFilterSliderState();
}

class _SearchFilterSliderState extends State<SearchFilterSlider> {
  SfRangeValues _values = const SfRangeValues(100.0, 800.0);

  @override
  void initState() {
    widget.minValue(_values.start.toInt());
    widget.maxValue(_values.end.toInt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfRangeSlider(
      max: 1000.0,
      values: _values,
      numberFormat: NumberFormat('###'),
      onChanged: (SfRangeValues values) {
        setState(() {
          _values = values;
          widget.minValue(values.start.toInt());
          widget.maxValue(values.end.toInt());
        });
      },
      enableTooltip: true,
      showDividers: true,
      interval: 100,
      shouldAlwaysShowTooltip: true,
      tooltipShape: const SfPaddleTooltipShape(),
    );
  }
}
