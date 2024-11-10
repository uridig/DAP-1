import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TennisDataModel.dart';
import 'TennisDetail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  _TennisState createState() => _TennisState();
}

class _TennisState extends State<Tennis> {
  Future<List<TennisDataModel>> fetchTennisData() async {
    final snapshot = await FirebaseFirestore.instance.collection('info-ten').get();
    return snapshot.docs.map((doc) {
      return TennisDataModel(
        doc['name'],
        doc['photo'],
        '${doc['name']} tiene ${doc['gs']} títulos de Grand Slam a lo largo de su carrera',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenistas'),
      ),
      body: FutureBuilder<List<TennisDataModel>>(
        future: fetchTennisData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final tennisData = snapshot.data!;
          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
