import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Background extends StatefulWidget {
  const Background({super.key});

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background>
    with SingleTickerProviderStateMixin {
  late List<Particle> particles;
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();

    particles = List.generate(
      50,
      (index) => Particle.random(
        width: 600,
        height: 701,
        maxXSpeed: 1.0,
        maxYSpeed: 0.5,
      ),
    );

    _ticker = createTicker((elapsed) {
      setState(() {});
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
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
        ..color = const Color.fromRGBO(114, 143, 103, 1.0)
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
  late double opacity;

  Particle({
    required this.width,
    required this.height,
  }) {
    r = width;
  }

  Particle.random({
    required this.width,
    required this.height,
    double maxXSpeed = 1,
    double maxYSpeed = 0.5,
    double minRadius = 2,
    double maxRadius = 4,
  }) {
    x = Random().nextDouble() * width;
    y = Random().nextDouble() * height;
    r = clampDouble(Random().nextDouble() * maxRadius, minRadius, maxRadius);
    xSpeed = Random().nextDouble() * maxXSpeed;
    ySpeed = Random().nextDouble() * maxYSpeed;
    opacity = Random().nextDouble().clamp(0.3, 1.0);
  }
}
