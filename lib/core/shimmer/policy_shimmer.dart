import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PolicyShimmer extends StatelessWidget {
  const PolicyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 78, 78, 78),
      highlightColor: Colors.grey[300]!,
      child: Container(
        height: mediaQuery.height,
        padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width / 40,
        ),
        width: mediaQuery.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
