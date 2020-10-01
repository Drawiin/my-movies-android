import 'package:flutter/material.dart';
import 'package:my_movies_app/styles/AppColors.dart';

class LoadingPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.textOnPrimary),
      ),
    );
  }
}
