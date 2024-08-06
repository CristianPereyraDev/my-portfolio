import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  const Background({super.key});

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  late List<Particle> particles;

  @override
  void initState() {
    particles = List.generate(
      50,
      (index) => Particle.random(
        width: 600,
        height: 701,
      ),
    );

    update();
    super.initState();
  }

  update() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParticlesPainter(particles: particles),
      child: Container(),
    );
  }
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;

  ParticlesPainter({required this.particles});

  double dist(double x1, double x2, double y1, double y2) {
    return sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < particles.length; i++) {
      var particle = particles[i];

      if (particle.x < 0 || particle.x > size.width) {
        particle.xSpeed *= -1;
      }
      if (particle.y < 0 || particle.y > size.height) {
        particle.ySpeed *= -1;
      }

      particle.x += particle.xSpeed;
      particle.y += particle.ySpeed;

      for (var j = i + 1; j < particles.length; j++) {
        var nextParticle = particles[j];
        var distance =
            dist(particle.x, nextParticle.x, particle.y, nextParticle.y);

        if (distance < 80) {
          var linePaint = Paint()
            ..color = Colors.black26
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2;
          Offset point1 = Offset(particle.x, particle.y);
          Offset point2 = Offset(nextParticle.x, nextParticle.y);
          canvas.drawLine(point1, point2, linePaint);
        }
      }

      var paint = Paint()
        ..color = const Color.fromARGB(255, 114, 143, 103)
        ..style = PaintingStyle.fill;
      var circlePosition = Offset(particle.x, particle.y);

      canvas.drawCircle(circlePosition, particle.r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  double width;
  double height;

  late double r;
  late double xSpeed;
  late double ySpeed;
  late double x;
  late double y;

  Particle({
    required this.width,
    required this.height,
  }) {
    r = width;
  }

  Particle.random({
    required this.width,
    required this.height,
  }) {
    x = Random().nextDouble() * width;
    y = Random().nextDouble() * height;
    r = (0.2 + Random().nextDouble()) * 2;
    xSpeed = Random().nextDouble() * 5;
    ySpeed = Random().nextDouble() * 1.5;
  }
}
