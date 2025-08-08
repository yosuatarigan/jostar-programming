import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jostar_programming/pages/portofolio_page.dart';
import 'package:jostar_programming/pages/service_page.dart';
import '../pages/home_page.dart';
import '../pages/store_page.dart';
import '../pages/about_page.dart';
import '../pages/contact_page.dart';
import '../widgets/layout/main_layout.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/services',
            name: 'services',
            builder: (context, state) => const ServicesPage(),
          ),
          GoRoute(
            path: '/portfolio',
            name: 'portfolio',
            builder: (context, state) => const PortfolioPage(),
          ),
          GoRoute(
            path: '/store',
            name: 'store',
            builder: (context, state) => const StorePage(),
          ),
          GoRoute(
            path: '/about',
            name: 'about',
            builder: (context, state) => const AboutPage(),
          ),
          GoRoute(
            path: '/contact',
            name: 'contact',
            builder: (context, state) => const ContactPage(),
          ),
        ],
      ),
    ],
  );
}