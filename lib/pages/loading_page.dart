import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // RefreshProgressIndicator(),
            LinearProgressIndicator(),
            SizedBox(height: 10,),
            Text(
              'Carregando...',
              style: TextStyle(
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
  
}