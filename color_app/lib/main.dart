import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Scaffold(body: Home())));
}

enum CardType { red, blue, green, pink }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final ColorService _service = ColorService();

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _service,
        builder: (context, _) {
          return _currentIndex == 0 ? ColorTapsScreen(service: _service) : StatisticsScreen(service: _service);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.tap_and_play), label: 'Taps'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistics'),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  final ColorService service;

  const ColorTapsScreen({super.key, required this.service});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: CardType.values.map((type) {
          return ColorTap(type: type, tapCount: service.getTapCount(type), onTap: () => service.incrementTapCount(type));
        }).toList(),
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({super.key, required this.type, required this.tapCount, required this.onTap});

  Color get backgroundColor {
    switch (type) {
      case CardType.red:
        return Colors.red;
      case CardType.blue:
        return Colors.blue;
      case CardType.green:
        return Colors.green;
      case CardType.pink:
        return Colors.pinkAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text('Taps: $tapCount', style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  final ColorService service;

  const StatisticsScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: service.allCounts.entries.map((entry) {
            return Text('${entry.key.name} Taps: ${entry.value}', style: TextStyle(fontSize: 24));
          }).toList(),
        ),
      ),
    );
  }
}

class ColorService extends ChangeNotifier {
  final Map<CardType, int> _tapCounts = {for (var type in CardType.values) type: 0};

  int getTapCount(CardType type) => _tapCounts[type] ?? 0;

  void incrementTapCount(CardType type) {
    _tapCounts[type] = getTapCount(type) + 1;
    notifyListeners();
  }

  Map<CardType, int> get allCounts => _tapCounts;
}
