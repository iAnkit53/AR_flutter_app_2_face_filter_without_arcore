import 'package:flutter/material.dart';
import 'dart:async';

import 'package:banuba_sdk/banuba_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _banubaSdkManager = BanubaSdkManager();
  final _epWidget = EffectPlayerWidget(key: null);

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await _banubaSdkManager.initialize([],
        'EtszWsRc+6mEqZdJMQNrfTRKfl6KoEI4M7W1GH3HmBnIrkvZ5UFkfyXBArfdDPJ+ruILLhDjOrIbQji4RQLoFqZ6zIvTZOOVAcdrM/qGgzdNiv1jLHq12mexlUOOm7mxDBeuccYFsN5AggiYDzhEQAD42AxMTvFOvMP+3tmO8h9yOzUbFjK4AlOFL0jWE703NrxoOfEs7ICJKtPohX3ObFYoL1D8Qb/uWUPRnS3S+Bu9Qa1sid/4OZABtoxZp2Pp2Hs/r+Id2/7WwqUx4N3+g75l5B1UwBsQv73urcNXlx4AeW+3p5opSq9L4TGg0+ZrRBvzffK5uUkZyaDTNmyca7Bxn4Xq9RAcNUtdijPckDB9Z1kGxCTsnEtYif1xEk0tEfAfowi5yzbo7N2XajwXILQu8/PoWpvnRxZ4o59cfcl41AQTiUae07/ufUxnGtPJKF/co/pCG9DcOZkgyQ0119ywql5j9vOgxGIPd/M28Emn9wIsT2LVbRQzhrscv1MUR2lWWddq/F+8DPyR3i2dYbuCeB5RaxRBLpceTCY=',
        SeverityLevel.info);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
    await _banubaSdkManager.openCamera();
    await _banubaSdkManager.attachWidget(_epWidget.banubaId);

    await _banubaSdkManager.startPlayer();
    await _banubaSdkManager.loadEffect("effects/TrollGrandma");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _epWidget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _banubaSdkManager.startPlayer();
    } else {
      _banubaSdkManager.stopPlayer();
    }
  }
}