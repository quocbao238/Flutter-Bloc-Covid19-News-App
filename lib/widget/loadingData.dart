
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WidgetLoadData extends StatelessWidget {
  final double height;
  final double width;
  const WidgetLoadData({this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        direction: ShimmerDirection.ltr,
        enabled: true,
        child: Container(
          color: Colors.black87,
          height: height,
        ),
      ),
    );
  }
}
