// import 'package:delivery_app/const/controllers.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class LineChartSample2 extends StatefulWidget {
//   const LineChartSample2({super.key});

//   @override
//   State<LineChartSample2> createState() => _LineChartSample2State();
// }

// class _LineChartSample2State extends State<LineChartSample2> {
//   List<Color> gradientColors = [
//     Colors.blue,
//     Colors.red.shade900,
//   ];

//   bool showAvg = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AspectRatio(
//           aspectRatio: 1.45,
//           child: Padding(
//             padding: const EdgeInsets.only(
//               right: 5,
//               left: 5,
//               top: 5,
//               bottom: 12,
//             ),
//             child: LineChart(
//               mainData(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 2:
//         text = const Text('MAR', style: style);
//         break;
//       case 5:
//         text = const Text('JUN', style: style);
//         break;
//       case 8:
//         text = const Text('SEP', style: style);
//         break;
//       default:
//         text = const Text('', style: style);
//         break;
//     }

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }

//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 15,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = '10K';
//         break;
//       case 2:
//         text = '20k';
//         break;
//       case 3:
//         text = '30k';
//         break;
//       case 4:
//         text = '40k';
//         break;
//       case 5:
//         text = '50k';
//         break;
//       default:
//         return Container();
//     }

//     return Text(text, style: style, textAlign: TextAlign.left);
//   }

//   LineChartData mainData() {
//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         horizontalInterval: 1,
//         verticalInterval: 1,
//         getDrawingHorizontalLine: (value) {
//           return const FlLine(
//             color: Colors.transparent,
//             strokeWidth: 0.3,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: Colors.transparent,
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             interval: 1,
//             //getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 42,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d)),
//       ),
//       minX: 0,
//       maxX: 12,
//       minY: 0,
//       maxY: 1000000,
//       lineBarsData: [
//         LineChartBarData(
//           //spots: orderController.allOrders.map((element) => FlSpot(element.totalAmount!, double.parse(element.time!.month.toString()))).toList(),
//           spots: orderController.allOrders.map((element) =>
//            FlSpot(double.parse(element.time!.month.toString()), element.totalAmount!)).toList(),
//           // spots: [
//           //   FlSpot(2, 2),
//           //   FlSpot(3, 1),
//           //   FlSpot(4, 5),
//           // ],
//           // spots:  [
//           //   FlSpot(0, 2),
//           //   FlSpot(double.parse("${orderController.allOrders.length}"), 2),
//           //   FlSpot(4.9, 5),
//           //   FlSpot(6.8, 3.1),
//           //   FlSpot(8, 4),
//           //   FlSpot(9.5, 3),
//           // ],
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: gradientColors,
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.3))
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
