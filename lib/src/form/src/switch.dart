// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:flutter/material.dart';

class BasicSwitch extends StatefulWidget {
  const BasicSwitch({
    super.key,
    required this.isEnabled,
    required this.onChanged,
    this.activeColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
    this.activeTrackColor,
    this.activeThumbColor,
  });

  /// The current state of the switch (true = switched on, false = switched off).
  final bool isEnabled;

  /// The color to use for the switch when it is in the "on" state.
  final Color? activeColor;

  /// The color to use for the switch when it is in the "off" state.
  final Color? inactiveTrackColor;

  /// The color used to inactive the trackColor of the switch.
  final Color? activeTrackColor;

  /// The color to use for the thumb of the switch.
  final Color? inactiveThumbColor;

  /// A callback function that is called when the switch is toggled.
  final Color? activeThumbColor;

  /// It provides the new state of the switch (true or false).
  final ValueChanged<bool> onChanged;

  @override
  State<BasicSwitch> createState() => _BasicSwitchState();
}

class _BasicSwitchState extends State<BasicSwitch> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      thumbColor: WidgetStateProperty.all(widget.activeThumbColor),
      activeTrackColor: widget.activeTrackColor,
      value: isSwitched,
      // Set the current value of the switch (on/off)
      onChanged: (value) {
        setState(() {
          isSwitched = value;
          widget.onChanged(isSwitched);
        });
      },
      // Notify the parent widget when the switch is toggled
      activeThumbColor: widget.activeColor,
      // Color for the switch when active (on)
      inactiveThumbColor: widget.inactiveThumbColor,
      // Color for the thumb when inactive (off)
      inactiveTrackColor: widget.inactiveTrackColor, // Color for the track when inactive
    );
  }
}
