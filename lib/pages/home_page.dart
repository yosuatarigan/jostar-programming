import 'package:flutter/material.dart';
import 'package:jostar_programming/widgets/home/portofolio_preview.dart';
import 'package:jostar_programming/widgets/home/service_overview.dart';
import 'package:jostar_programming/widgets/home/testimonial.dart';
import 'package:jostar_programming/widgets/home/why_chosse_us.dart';
import '../widgets/home/hero_section.dart';
import '../widgets/home/cta_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HeroSection(),
          const ServicesOverview(),
          const PortfolioPreview(),
          const WhyChooseUs(),
          const Testimonials(),
          const CTASection(),
        ],
      ),
    );
  }
}