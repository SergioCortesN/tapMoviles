import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State <LoginScreen> createState() =>  _LoginScreenState();
}

class  _LoginScreenState extends State <LoginScreen> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    final txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: 'Email User',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder()
      ),
    );
    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'Password User',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder()
      ),
    );

    final conCredencials = Positioned(
      bottom: 120,
      child: Container(
        
        decoration: BoxDecoration(
        
          //color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        
        ),
        width: 350,
        height: 200,
        child: ListView(
          children: [
            txtUser,
            const SizedBox(height: 10),
            txtPwd,
          ],
        ),
      ),
    );

    final imgTitulo = Positioned(
      top: 100,
      width: 300,
      height: 300,
      child: Image.asset('assets/titulo.png'),
    );

    final imgBoton = Positioned(
      bottom: 100,
      width: 100,
      height: 100,
      child: GestureDetector(
        onTap: () {
          isLoading = true;
          setState(() {});
          Future.delayed(Duration(seconds: 3)).then(
            (value) { 
              isLoading = false;
              setState(() {});
              Navigator.pushNamed(context,'/dash');
              }
          );
        },
        child: Image.asset('assets/raikou.png')
        ),
    );

    const progress = Positioned(
      top: 320,
      child: CircularProgressIndicator()
      );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            //opacity: 0.5,
            fit: BoxFit.cover,
            image: AssetImage('assets/zap.jpeg')
            )
        ),
        child:  Stack(
          alignment: Alignment.bottomCenter,
          children: [
            imgTitulo,
            isLoading ? progress : Container(),
            conCredencials,
            imgBoton,
          ],
        ),
      ),
    );
  }
}