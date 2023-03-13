import 'package:flutter/material.dart';
import 'package:notes_app/presentation/view/onboarding/layout/onboarding_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingBody(),
    );
  }
}
