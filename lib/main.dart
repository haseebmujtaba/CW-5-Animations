/*
22k-4307 Haseeb Mujtaba
22k-4508 Murtaza Johar
22k-4414 Shahmir
22k-4345 Saad Ahmed
*/

import 'package:flutter/material.dart';
import 'explicit_animation_widget.dart';
import 'implicit_animation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW#5 – Animations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
      ),
      home: const AnimationsPage(),
    );
  }
}

class AnimationsPage extends StatelessWidget {
  const AnimationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text(
          'CW#5 – Implicit & Explicit Animations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Explicit Animation ──
            SectionLabel(
              title: '🎬 Explicit Animation',
              subtitle: 'AnimationController + FadeTransition',
            ),
            SizedBox(height: 12),
            ExplicitAnimationWidget(),

            SizedBox(height: 32),

            // ── Implicit Animation ──
            SectionLabel(
              title: '✨ Implicit Animation',
              subtitle: 'AnimatedContainer',
            ),
            SizedBox(height: 12),
            ImplicitAnimationWidget(),
          ],
        ),
      ),
    );
  }
}

class SectionLabel extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionLabel({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
        ),
        const SizedBox(height: 6),
        Container(height: 1, color: const Color(0xFF6C63FF).withOpacity(0.4)),
      ],
    );
  }
}
