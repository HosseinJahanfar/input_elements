import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class LightFlash extends StatefulWidget {
  const LightFlash({super.key});

  @override
  State<LightFlash> createState() => _LightFlashState();
}

class _LightFlashState extends State<LightFlash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flashlight App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _turnOnFlash(context);
              },
              child: const Text("Flashlight Turn ON"),
            ),
            ElevatedButton(
                onPressed: () {
                  _turnOffFlash(context);
                },
                child: const Text("Flashlight Turn OFF")),
          ],
        ),
      ),
    );
  }
//!_turnOnFlash
  Future<void> _turnOnFlash(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      _showErrorMes('Could not enable Flashlight', context);
    }
  }
//!_turnOffFlash
  Future<void> _turnOffFlash(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      _showErrorMes('Could not enable Flashlight', context);
    }
  }
//!_showErrorMes
  void _showErrorMes(String mes, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mes)));
  }
}
