import 'dart:async';
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:robotxp_dashboard/app/utils.dart';
import 'package:robotxp_dashboard/app/widgets/filter_menu.dart';

import '../stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final store = GetIt.I<HomeStore>();

  late Timer timer;

  @override
  void initState() {
    super.initState();
    store.config(this);
    store.fetchAll();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      store.fetchAll();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  final buttons = <List<double?>>[
    [0, null, null, 132],
    [185, null, null, 0],
    [null, null, 0, 152],
    [74, 0, null, null],
    [null, 0, 160, null],
    [0, 90, null, null],
  ];

  Widget _buildImage(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: min(512, width - 64),
      width: min(512, width - 64),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black),
        image: const DecorationImage(
          image: AssetImage('assets/robot.png'),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.constrainHeight();
          final s = size / 428;
          final button = s * 48;
          final padding = s * 16;
          ButtonStyle getStyle(bool selected, {bool hasPadding = false}) =>
              ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(button / 2),
                  side: const BorderSide(color: Colors.black),
                ),
                primary: selected ? RobotColors.primary : Colors.white,
                onPrimary: Colors.black,
                padding: hasPadding
                    ? EdgeInsets.symmetric(horizontal: 24 * s)
                    : EdgeInsets.zero,
                surfaceTintColor: RobotColors.primary,
              ).copyWith(
                overlayColor: MaterialStateProperty.all(
                  RobotColors.primary.withOpacity(0.2),
                ),
              );

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  height: button,
                  child: Observer(
                    builder: (_) => ElevatedButton(
                      onPressed: () {
                        store.selected = null;
                      },
                      style: getStyle(store.selected == null, hasPadding: true),
                      child: Text(
                        "TODAS",
                        style: TextStyle(fontSize: 24 * s),
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  buttons.length,
                  (index) {
                    final b = buttons[index];
                    return Positioned(
                      left: b[0] != null ? b[0]! * s : null,
                      top: b[1] != null ? b[1]! * s : null,
                      right: b[2] != null ? b[2]! * s : null,
                      bottom: b[3] != null ? b[3]! * s : null,
                      height: button,
                      width: button,
                      child: Observer(
                        builder: (_) => ElevatedButton(
                          onPressed: () => store.selected = index,
                          style: getStyle(store.selected == index),
                          child: Text(
                            store.jointNames[index],
                            style: TextStyle(fontSize: 24 * s),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMain(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final w = min<double>(704, width - 64);
    return SizedBox(
      height: 512,
      width: w,
      child: LayoutBuilder(
        builder: (context, constraints) => Observer(
          builder: (_) => Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Colors.black),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        elevation: 0,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: const SizedBox(
                        height: 48,
                        child: Center(child: Text("FILTRO")),
                      ),
                    ),
                    if (store.filter != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        height: 48,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                              store.filter!.title,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              onPressed: () => store.setFilter(null),
                              icon: const Icon(Icons.close_rounded),
                              color: Colors.grey,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints.expand(
                                  height: 32, width: 32),
                              iconSize: 16,
                            ),
                          ],
                        ),
                      )
                    ]
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child:
                            _buildBigValue("ENERGIA", store.totalPower, "kWh"),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: _buildBigValue("GASTO", store.totalMoney, "R\$"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 32,
          child: Observer(
            builder: (_) => Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: store.isOn ? Colors.red : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black),
                    boxShadow: store.isOn
                        ? [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 8,
                              offset: const Offset(0, 0),
                            )
                          ]
                        : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  store.isOn ? "ON" : "OFF",
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text(
                "Robô UR-5",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Observer(builder: (_) {
                return Text(
                  store.selectedText,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(width: 32),
      ],
    );
  }

  Widget _buildBigValue(String title, double value, String unit) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 7),
            FittedBox(
              child: Text(
                value.toStringAsFixed(4).replaceAll(".", ","),
                style:
                    const TextStyle(fontSize: 96, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(flex: 4),
            Text(
              unit,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraph(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 400,
      width: min(width - 64, 736 + 512 + 32),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 24),
            child: Text(
              "Evolução da Potência (Watt)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) => charts.TimeSeriesChart(
                store.series,
                animate: false,
                primaryMeasureAxis: const charts.NumericAxisSpec(
                  tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    dataIsInWholeNumbers: false,
                    desiredTickCount: 10,
                  ),
                ),
                customSeriesRenderers: [
                  charts.LineRendererConfig(
                    customRendererId: 'area',
                    includeArea: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: const FilterMenu(),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 32,
              spacing: 32,
              children: [
                _buildMain(context),
                _buildImage(context),
                _buildGraph(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
