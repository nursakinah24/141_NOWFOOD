import 'package:flutter/material.dart';
import 'package:nowfood/manager/values_manager.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final String imagePath;

  const FeatureCard({
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           /*  Icon(
              iconData,
              size: 48,
              color: Colors.white,
            ), */
             Image.asset(
              imagePath,
              height: 80,
              width: 80,
            ),
            SizedBox(height: SizeManager.sizeM),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              ),
            SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}