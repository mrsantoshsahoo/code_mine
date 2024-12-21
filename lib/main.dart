import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'app/app.dart';
import 'app/demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const MyApp());
}

extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.dark;
  late final GoRouter router = GoRouter(
    initialLocation: '/flutter/dashboard/apps/all',
    redirect: (context, state) async {
      final path = state.uri.path;
      // Redirect `/flutter` to `/flutter/dashboard/apps`
      if (path == '/flutter') {
        return '/flutter/dashboard/apps/all';
      }
      // Redirect `/flutter/dashboard` to `/flutter/dashboard/apps`
      if (path == '/flutter/dashboard') {
        return '/flutter/dashboard/apps/all';
      }
      // Return null for all other paths to proceed normally
      return null;
    },
    routes: [
      GoRoute(
        path: '/:tab1/:tab2/:tab3/:tab4',
        builder: (context, state) {
          final selectedTab = state.pathParameters['tab'] ?? 'apps';
          return AdminScreen(
            selectedTab: selectedTab,
            goRouterState: state,
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "cod mine",
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData.dark(),
    );
  }
}


class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              bottom: isSelected ? 200 : 100,
              left: isSelected ? 250 : 100,
              child: AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationController.value * (3.14 / 2), // Rotate up to 90 degrees
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    isSelected = !isSelected;
                    setState(() {});
                    if (isSelected) {
                      _rotationController.forward(); // Start rotation
                    } else {
                      _rotationController.reverse(); // Reverse rotation
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white, width: 4),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(60),
                            bottomLeft: Radius.circular(60),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 146,
                        child: Container(
                          height: 50,
                          width: 42,
                          color: Colors.green,
                        ),
                      ),
                      Positioned(
                        bottom: 104,
                        child: Container(
                          height: 50,
                          width: 42,
                          color: Colors.blue,
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        child: Container(
                          height: 100,
                          width: 42,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_3 = Path();
    path_3.moveTo(0, 0);
    path_3.cubicTo(0.69320343, -0.0087616, 1.38640686, -0.01752319, 2.10061646,
        -0.02655029);
    path_3.cubicTo(4.38819316, -0.04852494, 6.67383001, -0.03399796, 8.96142578,
        -0.01708984);
    path_3.cubicTo(10.55559662, -0.02045937, 12.14976495, -0.02531313,
        13.743927, -0.03158569);
    path_3.cubicTo(17.08474186, -0.03895495, 20.42488796, -0.02825358,
        23.765625, -0.00488281);
    path_3.cubicTo(28.03872576, 0.02355983, 32.31025321, 0.00723164,
        36.58329582, -0.02274513);
    path_3.cubicTo(39.8760248, -0.04085687, 43.16838399, -0.03504178,
        46.46112442, -0.02210617);
    path_3.cubicTo(48.03592237, -0.0187804, 49.61075435, -0.02283004,
        51.18551254, -0.03450394);
    path_3.cubicTo(
        53.39280107, -0.04727281, 55.59758455, -0.02775588, 57.8046875, 0);
    path_3.cubicTo(59.05837128, 0.00397797, 60.31205505, 0.00795593,
        61.60372925, 0.01205444);
    path_3.cubicTo(66.16158883, 0.85623777, 67.80170243, 2.36208937,
        71.03173828, 5.64697266);
    path_3.cubicTo(71.78173828, 8.52197266, 71.78173828, 8.52197266,
        71.03173828, 11.64697266);
    path_3.cubicTo(69.61972099, 13.56298432, 68.11861303, 15.24742503,
        66.44189453, 16.93603516);
    path_3.cubicTo(63.29683862, 20.75192017, 63.88445314, 25.56257607,
        63.88697815, 30.28056335);
    path_3.cubicTo(63.8834513, 31.05350591, 63.87992446, 31.82644847,
        63.87629074, 32.62281352);
    path_3.cubicTo(63.8656089, 35.21510114, 63.86192362, 37.80735201,
        63.8581543, 40.3996582);
    path_3.cubicTo(63.8518485, 42.25754451, 63.84508267, 44.1154293,
        63.83789062, 45.97331238);
    path_3.cubicTo(63.82322073, 49.97621534, 63.81149582, 53.97911247,
        63.80194283, 57.98203087);
    path_3.cubicTo(63.78648746, 64.31518156, 63.76253735, 70.64828233,
        63.73704529, 76.98139954);
    path_3.cubicTo(63.66585363, 94.99122969, 63.60610468, 113.00108855,
        63.55493164, 131.01098633);
    path_3.cubicTo(63.5265982, 140.95622344, 63.49119956, 150.90141098,
        63.44827789, 160.84659606);
    path_3.cubicTo(63.42155101, 167.13800972, 63.40361762, 173.42936731,
        63.39224064, 179.72082651);
    path_3.cubicTo(63.38309139, 183.64255453, 63.3657183, 187.56421468,
        63.34606171, 191.48590279);
    path_3.cubicTo(63.33861091, 193.299467, 63.33450664, 195.11304865,
        63.33406639, 196.92662811);
    path_3.cubicTo(63.32728657, 212.38365526, 62.12769139, 224.9512383,
        51.03173828, 236.64697266);
    path_3.cubicTo(50.37173828, 236.64697266, 49.71173828, 236.64697266,
        49.03173828, 236.64697266);
    path_3.cubicTo(49.03173828, 237.30697266, 49.03173828, 237.96697266,
        49.03173828, 238.64697266);
    path_3.cubicTo(47.8066693, 239.30054544, 46.57644312, 239.94445498,
        45.34423828, 240.58447266);
    path_3.cubicTo(44.3175, 241.12394531, 44.3175, 241.12394531, 43.27001953,
        241.67431641);
    path_3.cubicTo(38.76336607, 243.63270508, 34.46421473, 243.78344492,
        29.59423828, 243.77197266);
    path_3.cubicTo(28.50240234, 243.77455078, 27.41056641, 243.77712891,
        26.28564453, 243.77978516);
    path_3.cubicTo(23.11981304, 243.65056754, 20.14138283, 243.23794583,
        17.03173828, 242.64697266);
    path_3.cubicTo(17.03173828, 241.98697266, 17.03173828, 241.32697266,
        17.03173828, 240.64697266);
    path_3.cubicTo(15.92185547, 240.50001953, 15.92185547, 240.50001953,
        14.78955078, 240.35009766);
    path_3.cubicTo(9.41333946, 238.97939222, 5.40798474, 234.54524363,
        2.21923828, 230.14697266);
    path_3.cubicTo(-1.46679419, 222.3869043, -3.12424957, 216.39932671,
        -3.07937622, 207.83065796);
    path_3.cubicTo(-3.07937524, 207.05010501, -3.07937425, 206.26955205,
        -3.07937324, 205.46534598);
    path_3.cubicTo(-3.07834121, 202.85317314, -3.07032959, 200.24106687,
        -3.0625, 197.62890625);
    path_3.cubicTo(-3.06062044, 195.75441533, -3.05927575, 193.8799238,
        -3.0584259, 192.00543213);
    path_3.cubicTo(-3.05614311, 187.96925689, -3.05142149, 183.93309413,
        -3.04523087, 179.89692307);
    path_3.cubicTo(-3.03682, 173.50854158, -3.04226497, 167.12022013,
        -3.05123901, 160.73184204);
    path_3.cubicTo(-3.05271002, 159.65297238, -3.05418103, 158.57410271,
        -3.05569661, 157.46254003);
    path_3.cubicTo(-3.05876734, 155.25638701, -3.06188737, 153.05023405,
        -3.06505561, 150.84408116);
    path_3.cubicTo(-3.08622643, 135.97378566, -3.09996363, 121.10368615,
        -3.06787109, 106.23339844);
    path_3.cubicTo(-3.0463175, 96.19978376, -3.04952422, 86.16651397,
        -3.08127964, 76.13292181);
    path_3.cubicTo(-3.09710571, 70.82664929, -3.10042169, 65.52103623,
        -3.07352066, 60.21479416);
    path_3.cubicTo(-3.04841603, 55.2190672, -3.05612297, 50.22444288,
        -3.08839989, 45.2287674);
    path_3.cubicTo(-3.09446788, 43.40151818, -3.08872455, 41.57418311,
        -3.06990623, 39.74702072);
    path_3.cubicTo(-2.97598871, 29.94651323, -3.07479997, 22.81842919,
        -9.40048027, 14.77089882);
    path_3.cubicTo(-10.96826172, 12.64697266, -10.96826172, 12.64697266,
        -11.65576172, 8.77197266);
    path_3.cubicTo(-10.12441409, 1.81130162, -6.85475168, 0.02177792, 0, 0);
    path_3.close();

    path_3.moveTo(-5.96826172, 3.64697266);
    path_3.cubicTo(-8.29146041, 6.51425899, -8.29146041, 6.51425899,
        -7.90576172, 10.02197266);
    path_3.cubicTo(-6.79971668, 14.29868014, -5.11454701, 15.65800163,
        -1.96826172, 18.64697266);
    path_3.cubicTo(-0.70909523, 22.84565975, -0.82383253, 27.12365107,
        -0.83023071, 31.47001648);
    path_3.cubicTo(-0.82740943, 32.251275, -0.82458815, 33.03253352,
        -0.82168138, 33.83746654);
    path_3.cubicTo(-0.81335714, 36.4519572, -0.81199899, 39.06640539,
        -0.81054688, 41.6809082);
    path_3.cubicTo(-0.805877, 43.5570233, -0.80073315, 45.43313727, -0.79515076,
        47.30924988);
    path_3.cubicTo(-0.78387935, 51.34869467, -0.7754405, 55.38813213,
        -0.76903152, 59.42758751);
    path_3.cubicTo(-0.75833913, 65.81990165, -0.73809046, 72.21216309,
        -0.71591187, 78.60444641);
    path_3.cubicTo(-0.65403087, 96.78160179, -0.59999997, 114.95875407,
        -0.56689453, 133.13598633);
    path_3.cubicTo(-0.54852939, 143.17574598, -0.51956976, 153.2154173,
        -0.47888982, 163.25511199);
    path_3.cubicTo(-0.45785204, 168.5650575, -0.44236711, 173.87489184,
        -0.44008255, 179.18488121);
    path_3.cubicTo(-0.43792971, 184.18278333, -0.4219954, 189.18045403,
        -0.39569283, 194.1782856);
    path_3.cubicTo(-0.38852268, 196.00755409, -0.38638772, 197.83685069,
        -0.3897953, 199.66613007);
    path_3.cubicTo(-0.41096093, 213.19412155, 0.00435699, 224.55769395,
        10.03173828, 234.64697266);
    path_3.cubicTo(12.33179147, 236.37445941, 14.38462261, 237.42145614,
        17.03173828, 238.64697266);
    path_3.cubicTo(17.77294922, 239.00404297, 18.51416016, 239.36111328,
        19.27783203, 239.72900391);
    path_3.cubicTo(22.77318576, 240.89412182, 25.78933306, 240.91179604,
        29.46923828, 240.89697266);
    path_3.cubicTo(30.74669922, 240.90212891, 32.02416016, 240.90728516,
        33.34033203, 240.91259766);
    path_3.cubicTo(36.91724583, 240.65521127, 39.70490233, 239.94274184,
        43.03173828, 238.64697266);
    path_3.cubicTo(43.03173828, 237.98697266, 43.03173828, 237.32697266,
        43.03173828, 236.64697266);
    path_3.cubicTo(44.30017578, 236.43041016, 44.30017578, 236.43041016,
        45.59423828, 236.20947266);
    path_3.cubicTo(52.03762725, 233.28065949, 55.71977704, 227.02362497,
        58.39701796, 220.62511528);
    path_3.cubicTo(59.48187523, 217.24409481, 59.42871827, 213.85175948,
        59.38336182, 210.34217834);
    path_3.cubicTo(59.38592362, 209.12885862, 59.38592362, 209.12885862,
        59.38853717, 207.89102739);
    path_3.cubicTo(59.39078865, 205.19495901, 59.37182239, 202.49946419,
        59.35302734, 199.8034668);
    path_3.cubicTo(59.3505826, 197.86470157, 59.34955592, 195.92593411,
        59.34983826, 193.98716736);
    path_3.cubicTo(59.34801337, 189.818914, 59.33735439, 185.65080954,
        59.32016754, 181.48259163);
    path_3.cubicTo(59.29423005, 174.88901881, 59.29532234, 168.29562211,
        59.30145264, 161.70201111);
    path_3.cubicTo(59.31504099, 142.95482628, 59.29734601, 124.20780033,
        59.24121094, 105.46069336);
    path_3.cubicTo(59.21042656, 95.10154587, 59.20466184, 84.74268762,
        59.22609687, 74.38351339);
    path_3.cubicTo(59.23821023, 67.83134197, 59.21936447, 61.28022401,
        59.17761183, 54.72818577);
    path_3.cubicTo(59.15897597, 50.64905249, 59.16959935, 46.57038231,
        59.18846321, 42.49126625);
    path_3.cubicTo(59.19136179, 40.60306981, 59.18231681, 38.71481056,
        59.1602993, 36.82674026);
    path_3.cubicTo(58.9838882, 20.77486287, 58.9838882, 20.77486287,
        63.54901123, 15.70335388);
    path_3.cubicTo(64.18460339, 15.17701072, 64.82019554, 14.65066755,
        65.47504807, 14.1083746);
    path_3.cubicTo(67.45640838, 12.55247678, 67.45640838, 12.55247678,
        67.59423828, 8.77197266);
    path_3.cubicTo(67.32243099, 5.55722762, 67.32243099, 5.55722762,
        65.03173828, 3.64697266);
    path_3.cubicTo(61.96902465, 3.33194699, 61.96902465, 3.33194699,
        58.31884766, 3.37231445);
    path_3.cubicTo(57.62926468, 3.36720352, 56.9396817, 3.36209259, 56.22920227,
        3.35682678);
    path_3.cubicTo(53.94454323, 3.34290029, 51.66018477, 3.34388961,
        49.37548828, 3.34619141);
    path_3.cubicTo(47.79129931, 3.34230648, 46.20711137, 3.33797224, 44.6229248,
        3.33320618);
    path_3.cubicTo(
        41.30066553, 3.32573764, 37.97851252, 3.32604003, 34.65625, 3.33129883);
    path_3.cubicTo(30.39204088, 3.33709798, 26.12826548, 3.32015509,
        21.86412811, 3.29695415);
    path_3.cubicTo(18.5922388, 3.28224665, 15.32045471, 3.28134095, 12.04853821,
        3.28446388);
    path_3.cubicTo(10.47600952, 3.28394928, 8.90347515, 3.27868564, 7.33097839,
        3.26865196);
    path_3.cubicTo(
        5.13523885, 3.25636042, 2.94035403, 3.26303399, 0.74462891, 3.2746582);
    path_3.cubicTo(-1.1316217, 3.27371407, -1.1316217, 3.27371407, -3.04577637,
        3.27275085);
    path_3.cubicTo(-4.01019653, 3.39624405, -4.9746167, 3.51973724, -5.96826172,
        3.64697266);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Colors.white;
    canvas.drawPath(path_3, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

///
//void _setTheme() {
//   final params = router.routeInformationProvider.value.uri.queryParameters;
//   final themeParam = params.containsKey('theme') ? params['theme'] : null;
//
//   setState(() {
//     switch (themeParam) {
//       case 'dark':
//         setState(() {
//           themeMode = ThemeMode.dark;
//         });
//       case 'light':
//         setState(() {
//           themeMode = ThemeMode.light;
//         });
//       case _:
//         setState(() {
//           themeMode = ThemeMode.dark;
//         });
//     }
//   });
// }

// theme: ThemeData(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: lightPrimaryColor,
//     surface: lightSurfaceColor,
//     onSurface: Colors.black,
//     surfaceContainerHighest: lightSurfaceVariantColor,
//     onPrimary: lightLinkButtonColor,
//   ),
//   brightness: Brightness.light,
//   dividerColor: lightDividerColor,
//   dividerTheme: const DividerThemeData(
//     color: lightDividerColor,
//   ),
//   scaffoldBackgroundColor: Colors.white,
//   menuButtonTheme: MenuButtonThemeData(
//     style: MenuItemButton.styleFrom(
//       minimumSize: const Size.fromHeight(56),
//     ),
//   ),
// ),
// darkTheme: ThemeData(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: darkPrimaryColor,
//     brightness: Brightness.dark,
//     surface: darkSurfaceColor,
//     onSurface: Colors.white,
//     surfaceContainerHighest: darkSurfaceVariantColor,
//     onSurfaceVariant: Colors.white,
//     onPrimary: darkLinkButtonColor,
//   ),
//   brightness: Brightness.dark,
//   dividerColor: darkDividerColor,
//   dividerTheme: const DividerThemeData(
//     color: darkDividerColor,
//   ),
//   textButtonTheme: const TextButtonThemeData(
//     style: ButtonStyle(
//       foregroundColor: WidgetStatePropertyAll(darkLinkButtonColor),
//     ),
//   ),
//   scaffoldBackgroundColor: darkScaffoldColor,
//   menuButtonTheme: MenuButtonThemeData(
//     style: MenuItemButton.styleFrom(
//       minimumSize: const Size.fromHeight(56),
//     ),
//   ),
// ),
