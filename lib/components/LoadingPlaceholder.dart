import 'package:flutter/material.dart';
import 'package:my_movies_app/styles/AppColors.dart';

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.textOnPrimary),
      ),
    );
  }
}
