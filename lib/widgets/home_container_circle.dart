import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeContainerCircle extends StatelessWidget {
  String svgUrl;
  String label;
  HomeContainerCircle({
    super.key,
    required this.svgUrl,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle),
          padding: const EdgeInsets.all(20),
          child: SvgPicture.asset(
            width: 20,
            height: 20,
            svgUrl,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(),
        )
      ],
    );
  }
}
