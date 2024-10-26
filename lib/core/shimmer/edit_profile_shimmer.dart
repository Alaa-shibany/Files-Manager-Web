import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EditProfileShimmer extends StatelessWidget {
  const EditProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 78, 78, 78),
      highlightColor: Colors.grey[300]!,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: mediaQuery.height / 4.5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
              ),
            ),
            SizedBox(height: mediaQuery.height / 30),
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(mediaQuery.width / 30),
                child: Container(
                  height: mediaQuery.height / 15,
                  width: mediaQuery.width,
                  margin:
                      EdgeInsets.symmetric(horizontal: mediaQuery.width / 80),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                height: mediaQuery.height / 12,
                width: mediaQuery.width / 1.5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
