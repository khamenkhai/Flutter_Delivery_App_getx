import 'package:flutter/material.dart';

class TotalSalesScreen extends StatefulWidget {
  const TotalSalesScreen({super.key});

  @override
  State<TotalSalesScreen> createState() => _TotalSalesScreenState();
}

class _TotalSalesScreenState extends State<TotalSalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("TotalSales")),
    );
  }
}