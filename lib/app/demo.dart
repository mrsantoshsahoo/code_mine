import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class WaterTransferApp extends StatefulWidget {
  const WaterTransferApp({super.key});

  @override
  State<WaterTransferApp> createState() => _WaterTransferAppState();
}

class _WaterTransferAppState extends State<WaterTransferApp> with TickerProviderStateMixin {
  late AnimationController _moveController;
  late Animation<Offset> _bottlePosition;
  late Animation<double> _bottleRotation;
  late Animation<Offset> _waterStream;
  bool isTransferring = false;

  double bottle1WaterLevel = 0.6; // Initial water level in the first bottle
  double bottle2WaterLevel = 0.3; // Initial water level in the second bottle

  @override
  void initState() {
    super.initState();

    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _bottlePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(2, -1), // Move diagonally to the right and upward
    ).animate(
      CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
    );

    _bottleRotation = Tween<double>(begin: 0, end: 0.25) // Rotate by 45 degrees
        .animate(
      CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
    );

    _waterStream = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, -1), // Path for water stream animation
    ).animate(
      CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  void _startTransfer() {
    if (isTransferring) return;

    setState(() {
      isTransferring = true;
    });

    _moveController.forward(from: 0).then((_) {
      // Simulate pouring water
      setState(() {
        bottle1WaterLevel -= 0.1; // Decrease water level in bottle 1
        bottle2WaterLevel += 0.1; // Increase water level in bottle 2
      });

      // Reverse the animation (water falls back into bottle 1 after a delay)
      Future.delayed(const Duration(seconds: 1), () {
        _moveController.reverse().then((_) {
          setState(() {
            isTransferring = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bottle Water Transfer")),
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Second bottle (Target)
            Positioned(
              right: 100,
              bottom: 100,
              child: CustomPaint(
                painter: BottlePainter(bottle2WaterLevel), // Static water level
                child: const SizedBox(width: 100, height: 200),
              ),
            ),

            // First bottle (Movable)
            AnimatedBuilder(
              animation: _moveController,
              builder: (context, child) {
                return Transform.translate(
                  offset: _bottlePosition.value * 100, // Scale to match pixel movement
                  child: Transform.rotate(
                    angle: _bottleRotation.value * 3.14, // Rotate in radians
                    child: GestureDetector(
                      onTap: _startTransfer,
                      child: CustomPaint(
                        painter: BottlePainter(bottle1WaterLevel), // Initial water level
                        child: const SizedBox(width: 100, height: 200),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Water stream (Visible during pouring)
            if (isTransferring && _moveController.isCompleted)
              AnimatedBuilder(
                animation: _moveController,
                builder: (context, child) {
                  return Positioned(
                    left: 110, // Position where the water stream starts
                    bottom: 120, // Start position for the water stream
                    child: Transform.translate(
                      offset: _waterStream.value * 150, // Animate the stream of water
                      child: Container(
                        width: 10,
                        height: 100,
                        color: Colors.blue,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class BottlePainter extends CustomPainter {
  final double waterLevel;

  BottlePainter(this.waterLevel);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final waterHeight = size.height * waterLevel;

    // Draw water rectangle
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - waterHeight, size.width, waterHeight),
      paint,
    );

    // Bottle outline
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(Offset.zero & size, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
