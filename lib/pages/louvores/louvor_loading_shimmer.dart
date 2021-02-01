import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class LouvorLoadingShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Shimmer.fromColors(
                  period: Duration(seconds: 3),
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey[100],
                  child: Container(
                    color: Colors.white,
                    child: SizedBox(
                      width: Get.width * 0.5,
                      height: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: Shimmer.fromColors(
                  period: Duration(seconds: 3),
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey[100],
                  child: Container(
                    color: Colors.white,
                    child: SizedBox(
                      width: Get.width * 0.25,
                      height: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
