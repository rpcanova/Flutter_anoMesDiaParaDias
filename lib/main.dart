import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Color(0xff250a6f),
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintStyle: TextStyle(
            color: Color(0xff250a6f),
          ),
        ),
      ),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final anoController = TextEditingController();
  final mesController = TextEditingController();
  final diaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _mensagem = "";

  int ano = 0;
  int mes = 0;
  int dia = 0;

  _diaMesAnoParaDias() {
    setState(() {
      ano = int.parse(anoController.text);
      mes = int.parse(mesController.text);
      dia = int.parse(diaController.text);

      int dias = (ano * 360) + (mes * 30) + dia;
      _mensagem = "Você tem ${dias.toString()} dia(s)";
      anoController.clear();
      mesController.clear();
      diaController.clear();
    });
  }

  void _limpaCampos() {
    anoController.clear();
    mesController.clear();
    diaController.clear();
    setState(() {
      _mensagem = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Ano/Mês/Dia para Dias - Fatec Ferraz"),
        backgroundColor: Color(0xff250a6f),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _limpaCampos,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 40),
              const Icon(
                Icons.date_range,
                size: 150,
                color: Color(0xff250a6f),
              ),
              const SizedBox(height: 60),
              construirTextField(
                  "Ano", "Qtde: ", anoController, "Insira o(s) ano(s)"),
              const SizedBox(height: 20),
              construirTextField(
                  "Mês", "Qtde: ", mesController, "Insira o(s) mês(es)"),
              const SizedBox(height: 20),
              construirTextField(
                  "Dia", "Qtde: ", diaController, "Insira o(s) dia(s)"),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  color: Color(0xff250a6f),
                  width: 80,
                  height: 80,
                  child: InkWell(
                      child: const Center(
                        child: Text(
                          "Converter Ano/Mês/Dia para Dias",
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _diaMesAnoParaDias();
                        }
                      }),
                ),
              ),
              Center(
                child: Text(
                  _mensagem,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget construirTextField(String texto, String prefixo,
      TextEditingController c, String mensagemErro) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return mensagemErro;
        } else {
          return null;
        }
      },
      controller: c,
      decoration: InputDecoration(
        labelText: texto,
        labelStyle: const TextStyle(color: Color(0xff250a6f)),
        border: const OutlineInputBorder(),
        prefixText: prefixo,
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
      keyboardType: TextInputType.number,
    );
  }
}
