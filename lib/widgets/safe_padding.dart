import 'package:flutter/widgets.dart';

class SafePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const SafePadding({Key? key, required this.child, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 20,
            ),
        child: child,
      ),
    );
  }
}
