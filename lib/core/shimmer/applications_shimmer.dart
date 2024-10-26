import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ApplicationsShimmer extends StatelessWidget {
  const ApplicationsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
      child: Padding(
        padding: EdgeInsets.all(mediaQuery.width / 40),
        child: Container(
          height: mediaQuery.height / 12,
          width: mediaQuery.width,
          margin: EdgeInsets.symmetric(
            vertical: mediaQuery.height / 100,
            horizontal: mediaQuery.width / 50,
          ),
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      ),
    );
  }
}
