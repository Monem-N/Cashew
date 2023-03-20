import 'package:budget/functions.dart';
import 'package:budget/widgets/button.dart';
import 'package:budget/widgets/fadeIn.dart';
import 'package:budget/widgets/tappable.dart';
import 'package:flutter/material.dart';

class SaveBottomButton extends StatefulWidget {
  final String label;
  final Function() onTap;
  final bool disabled;
  const SaveBottomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.disabled = false,
  });

  @override
  State<SaveBottomButton> createState() => _SaveBottomButtonState();
}

class _SaveBottomButtonState extends State<SaveBottomButton>
    with WidgetsBindingObserver {
  bool isKeyboardOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    bool status = getIsKeyboardOpen(context);
    if (status != isKeyboardOpen)
      setState(() {
        isKeyboardOpen = status;
      });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform.translate(
          offset: Offset(0, 1),
          child: Container(
            height: 12,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  determineBrightnessTheme(context) == Brightness.light
                      ? Colors.white.withOpacity(0.0)
                      : Colors.black.withOpacity(0.0),
                  Theme.of(context).canvasColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 1],
              ),
            ),
          ),
        ),
        Tappable(
          onTap: widget.disabled ? () {} : widget.onTap,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            margin: isKeyboardOpen
                ? EdgeInsets.zero
                : EdgeInsets.only(bottom: bottomPaddingSafeArea),
            padding: isKeyboardOpen
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
            color: Theme.of(context).canvasColor,
            height: isKeyboardOpen ? 47 : 60,
            child: AnimatedClipRRect(
              duration: Duration(milliseconds: 500),
              borderRadius: isKeyboardOpen
                  ? BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : BorderRadius.circular(20),
              curve: Curves.easeInOutCubic,
              child: Button(
                changeScale: !isKeyboardOpen,
                borderRadius: isKeyboardOpen ? 0 : 20,
                label: widget.label,
                onTap: widget.disabled ? () {} : widget.onTap,
                color: widget.disabled ? Colors.grey : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class KeyboardHeightAreaAnimated extends StatefulWidget {
  const KeyboardHeightAreaAnimated({
    super.key,
  });

  @override
  State<KeyboardHeightAreaAnimated> createState() =>
      _KeyboardHeightAreaAnimatedState();
}

class _KeyboardHeightAreaAnimatedState extends State<KeyboardHeightAreaAnimated>
    with WidgetsBindingObserver {
  bool isKeyboardOpen = false;
  double totalHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    bool status = getIsKeyboardOpen(context);
    double height = getKeyboardHeight(context);

    setState(() {
      if (status != isKeyboardOpen) isKeyboardOpen = status;
      if (height != totalHeight) totalHeight = height;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(isKeyboardOpen);
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      color: Theme.of(context).canvasColor,
      height: isKeyboardOpen ? getKeyboardHeight(context) : 0,
      child: Container(color: Colors.red),
    );
  }
}
