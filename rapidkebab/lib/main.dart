import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: GlobalKey(),
      title: 'Rapid Kebab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        textTheme: const TextTheme(
          headline6: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900, color: Color.fromARGB(255, 255, 94, 0)),
          bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapid Kebab'),
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 90,
              right: 0,
              left: 0,
              child: Image.asset(
                'assets/icon/podklad.png',
                fit: BoxFit.cover,
                height: 47.0,
              ),
            ),
          ],
        ),
        leading: GestureDetector(
          onTap: () {
            // Do nothing
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/icon/logo.png'),
          ),
        ),
        toolbarHeight: 180.0, // 60-default
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            KebabOptionButton(
              label: 'Tortilla',
              imagePath: 'assets/icon/tortilla.png',
              nextPage: CustomizePage(
                title: 'Wybierz rozmiar tortilli',
                options: ['Mała - 16.00 zł', 'Średnia - 18.00 zł', 'Duża - 22.00 zł', 'XXL - 24.00 zł'],
                nextStep: CustomizePage(
                  title: 'Wybierz składniki',
                  options: [
                    'Wołowina',
                    'Baranina',
                    'Kurczak',
                    'Mieszane',
                  ],
                  nextStep: CustomizePage(
                    title: 'Wybierz surówkę',
                    options: [
                      'Z surówką',
                      'Bez surówki',
                    ],
                    nextStep: CustomizePage(
                      title: 'Wybierz frytki',
                      options: [
                        'Z frytkami - 1.50 zł',
                        'Bez frytek',
                      ],
                      nextStep: CustomizePage(
                        title: 'Wybierz sos',
                        options: [
                          'Łagodny sos ',
                          'Ostry sos ',
                          'Bardzo ostry sos  ',
                          'Mieszany sos ',
                        ],
                        nextStep: ConfirmationPage(title: 'Potwierdź zamówienie'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            KebabOptionButton(
              label: 'Frytki',
              imagePath: 'assets/icon/frytki.png',
              nextPage: CustomizePage(
                title: 'Wybierz rozmiar frytek',
                options: ['Małe - 10.00 zł', 'Średnie - 12.00 zł', 'Duże - 14.00 zł', 'XXL - 16.00 zł'],
                nextStep: CustomizePage(
                  title: 'Wybierz dodatki',
                  options: [
                    'Solone - 0.50 zł',
                    'Niesolone',
                  ],
                  nextStep: CustomizePage(
                    title: 'Wybierz sos',
                    options: [
                      'Ketchup',
                      'Tysiąca wysp',
                      'Musztarda',
                      'Majonez',
                      'Chili',
                    ],
                    nextStep: ConfirmationPage(title: 'Potwierdź zamówienie'),
                  ),
                ),
              ),
            ),
            KebabOptionButton(
              label: 'Napój',
              imagePath: 'assets/icon/napoj.png',
              nextPage: CustomizePage(
                title: 'Wybierz napój',
                options: [
                  'Coca-Cola - 8.00 zł',
                  'Pepsi - 8.00 zł',
                  'Mirinda - 7.00 zł',
                  'Mountain Dew - 7.50 zł',
                  'Sprite - 7.00 zł',
                  'Sok - 4.50 zł',
                  'Piwo - 12.00 zł',
                ],
                nextStep: ConfirmationPage(title: 'Potwierdź zamówienie'),
              ),
            ),
            KebabOptionButton(
              label: 'Więcej Wkrótce',
              imagePath: 'assets/icon/soon.png',
              nextPage: ComingSoonPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class KebabOptionButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final Widget nextPage;

  const KebabOptionButton({
    required this.label,
    required this.imagePath,
    required this.nextPage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Hero(
          tag: 'icon_${label.toLowerCase()}',
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => nextPage,
                ),
              );
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(label, style: Theme.of(context).textTheme.bodyText2),
      ],
    );
  }
}

class CustomizePage extends StatefulWidget {
  final String title;
  final List<String> options;
  final Widget nextStep;

  const CustomizePage({
    required this.title,
    required this.options,
    required this.nextStep,
    Key? key,
  }) : super(key: key);

  @override
  _CustomizePageState createState() => _CustomizePageState();
}

class _CustomizePageState extends State<CustomizePage> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: Theme.of(context).textTheme.headline6),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...widget.options.map((option) {
            return RadioListTile(
              title: Text(option, style: Theme.of(context).textTheme.bodyText2),
              value: option,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value as String?;
                });
              },
            );
          }).toList(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.nextStep,
                ),
              );
            },
            child: const Text('Dalej'),
          ),
        ],
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final String title;

  const ConfirmationPage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.headline6),
        leading: GestureDetector(
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'Zamówienie potwierdzone!',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class ComingSoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Więcej Wkrótce', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),

        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.info_outline,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              'Więcej opcji wkrótce!',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
