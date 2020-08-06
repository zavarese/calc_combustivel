import 'package:flutter/material.dart';
void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip cost calculator',
      home: new FuelForm(),
    );
  }
}
class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}
class _FuelFormState extends State<FuelForm> {
  String moeda = "Dollars";

  // Controlador da caixa de texto (TextField):
  // Controladores das caixas de texto:
  TextEditingController distanciaTotal = TextEditingController();
  TextEditingController distanciaUnitaria = TextEditingController();
  TextEditingController custoCombustivel = TextEditingController();
  // String que vai armazenar o conteúdo da caixa de texto:
  String texto = "";

  @override
  Widget build(BuildContext formContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Cost Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 5.0,
            ),
            child: TextField(
              controller: distanciaTotal,
              decoration: InputDecoration(
                labelText: 'Distância total',
                hintText: 'p.ex.124',
                labelStyle: Theme.of(context).textTheme.headline6,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 5.0,
            ),
            child: TextField(
              controller: distanciaUnitaria,
              decoration: InputDecoration(
                labelText: 'Distância por litro',
                hintText: 'p.ex. 9.5',
                labelStyle: Theme.of(context).textTheme.headline6,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 5.0,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: custoCombustivel,
                    decoration: InputDecoration(
                      labelText: 'Preço do combústivel',
                      hintText: 'p.ex. 3.7',
                      labelStyle: Theme.of(context).textTheme.headline6,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  width: 25.0,
                ),
                Expanded(
                  child: DropdownButton<String>(
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: 'Dollars',
                        child: Text('Dollars'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Euro',
                        child: Text('Euro'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Pounds',
                        child: Text('Pounds'),
                      ),
                    ],
                    value: moeda,
                    onChanged: (String v) {
                      setState(() {
                        moeda = v;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    'Submit',
                    textScaleFactor: 1.5,
                  ),
                  onPressed: () {
                    setState(() {
                      texto = calcula();
                    });
                  },
                ),
              ),
              Container(
                width: 15.0,
              ),
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).buttonColor,
                  textColor: Theme.of(context).primaryColorDark,
                  child: Text(
                    'Reset',
                    textScaleFactor: 1.5,
                  ),
                  onPressed: () {
                    distanciaTotal.text = '';
                    distanciaUnitaria.text = '';
                    custoCombustivel.text = '';
                    setState(() {
                      texto = '';
                    });
                  },
                ),
              ),
            ],
          ),
          Text(texto),
        ],
      ),
    );
  }

  // Função que faz os cálculos:
  String calcula() {
    // Aqui criamos variáveis pegando os valores digitados
    // nas caixas de texto (através dos controllers),
    // e convertemos para double.
    double distancia = double.parse(distanciaTotal.text);
    double distunit = double.parse(distanciaUnitaria.text);
    double custo = double.parse(custoCombustivel.text);
    // O cálculo...
    double total = distancia / distunit * custo;
    // Montando a string de saída, que vai ter o resultado
    // do cálculo.
    String saida = 'O custo total da viagem é de ' +
        total.toStringAsFixed(2) + ' ' + moeda;
    return saida;
  }
}

