import 'package:flutter/material.dart';
import 'package:hotel_page/utils/app_constants.dart';

class SecondContainerWidget extends StatelessWidget {
  const SecondContainerWidget({super.key, required this.firstText,required this.secondText});
  final String firstText;
  final String secondText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              firstText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: List.generate(5, (index) {
                return Icon(Icons.star_border, color: Colors.green, size: 14);
              }),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          secondText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppConstants.bottomNavigationBarUnselectedColor,
          ),
        ),
      ],
    );
  }
}
