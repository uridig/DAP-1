import 'package:flutter/material.dart';
import 'TennisDataModel.dart';
import 'TennisDetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app tenis',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final String _correctEmail = 'mail';
  final String _correctPassword = 'pass';

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email == _correctEmail && password == _correctPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Tennis()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email o Contraseña es incorrecta')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Alan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Ingrese su Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Ingrese su Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class Tennis extends StatefulWidget {
  const Tennis({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Tennis> {
  static List<String> tennisname = [
    'Roger Federer',
    'Rafa Nadal',
    'Novak Djokovic',
    'Stan Wawrinka',
    'Daniil Medvedev'
  ];

  static List url = [
    'https://cdn.britannica.com/57/183257-050-0BA11B4B/Roger-Federer-2012.jpg',
    'https://e00-elmundo.uecdn.es/assets/multimedia/imagenes/2022/06/24/16560843481540.jpg',
    'https://fotografias.lasexta.com/clipping/cmsimages02/2024/06/04/750CEA27-93F8-42B3-B064-93C7F00CB99F/novak-djokovic_98.jpg?crop=4347,2446,x0,y222&width=1900&height=1069&optimize=low&format=webply',
    'https://www.newlyswissed.com/wp-content/uploads/2020/11/Stanislaw-Wawrinka-Swiss-Tennis-Player-02.jpg',
    'https://ogimg.infoglobo.com.br/esportes/25413693-b96-69f/FT1086A/97787689_Russias-Daniil-Medvedev-returns-the-ball-to-Spains-Rafael-Nadal-during-their-Mexico-ATP-O.jpg'
  ];

  static List<String> tennisgs = ['20', '22', '24', '3', '1'];

  final List<TennisDataModel> tennisData = List.generate(
    tennisname.length,
    (index) => TennisDataModel(
      tennisname[index],
      url[index],
      '${tennisname[index]} tiene ${tennisgs[index]} titulos de Grand Slam a lo largo de su carrera',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenistas'),
      ),
      body: ListView.builder(
        itemCount: tennisData.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(tennisData[index].name),
              leading: SizedBox(
                width: 50,
                height: 50,
                child: Image.network(tennisData[index].imageUrl),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TennisDetail(
                      tennisDataModel: tennisData[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
