import 'package:flutter/material.dart';

class ShadedBackground extends StatelessWidget {
  const ShadedBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Theme.of(context).backgroundColor.withAlpha(120),
            Theme.of(context).backgroundColor.withAlpha(200),
            Theme.of(context).backgroundColor,
            Theme.of(context).backgroundColor,
          ],
        ).createShader(rect);
      },
      blendMode: BlendMode.xor,
      // child: Image.asset(
      //   "assets/images/working_male.png",
      //   fit: BoxFit.cover,
      // ),
    );
  }
}
