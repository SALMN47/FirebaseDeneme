import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset('assets/rolex.png'),
            SizedBox(
              height: 200,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  textAlign: TextAlign.center,
                  'Lets find you favorite watch',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.green[900], fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
