import 'package:flutter/material.dart';
import 'package:sakeena_app/features/home/presentation/view/widgets/custom_nav_bar.dart';
import 'package:sakeena_app/features/home/presentation/view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: HomeViewBody()),
      
    );
  }
}
