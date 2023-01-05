import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_app/stockapphome.dart';

void main() {
  runApp(const StockTracker());
}

class StockTracker extends StatelessWidget {
  const StockTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StockAppHome(),
    );
  }
}
