import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const Banco());

class Banco extends StatelessWidget {
  const Banco({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              context,
              title: 'Contatos',
              icon: Icons.contact_phone,
              onTap: () {
                // Redireciona para a lista de contatos
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaContatos()),
                );
              },
            ),
            _buildDashboardCard(
              context,
              title: 'Transferências',
              icon: Icons.monetization_on,
              onTap: () {
                // Redireciona para a lista de transferências
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaTransferencia()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para criar os cards
  Widget _buildDashboardCard(BuildContext context, {required String title, required IconData icon, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.greenAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.green),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaContatos extends StatefulWidget {
  final List<Contato> _contatos = [];

  ListaContatos({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListaContatosState();
  }
}

class ListaContatosState extends State<ListaContatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Contatos", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: widget._contatos.length,
        itemBuilder: (context, indice) {
          return ItemContato(widget._contatos[indice]);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Contato?> future = Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioContato()),
          );

          future.then((contatoRecebido) {
            if (contatoRecebido != null) {
              setState(() {
                widget._contatos.add(contatoRecebido);
              });
            }
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(size: 35, color: Colors.white, Icons.add_circle_rounded),
      ),
    );
  }
}

class ItemContato extends StatelessWidget {
  final Contato _contato;
  const ItemContato(this._contato, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.contact_phone, color: Colors.green),
        title: Text(_contato.name), // Exibe o nome do contato
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CPF: ${_contato.cpf}'),
            Text('E-mail: ${_contato.email}'),
            Text('Celular: ${_contato.phone}'),
            Text('Endereço: ${_contato.address}'),
          ],
        ),
      ),
    );
  }}

class Contato {
  final String cpf;
  final String name;
  final String email;
  final String phone;
  final String address;

  Contato(this.cpf, this.name, this.email, this.phone, this.address);

  @override
  String toString() {
    return 'Contato {cpf: $cpf, name: $name, email: $email, phone: $phone, address: $address}';
  }
}

class FormularioContato extends StatelessWidget {
  final TextEditingController _controllerCpf = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();

  FormularioContato({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Novo Contato", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Editor(controlador: _controllerName, rotulo: 'Nome', dica: 'João Borges'),
          Editor(controlador: _controllerCpf, rotulo: 'CPF', dica: '123.456.789-10'),
          Editor(controlador: _controllerEmail, rotulo: 'E-mail', dica: 'joao@borges.com'),
          Editor(controlador: _controllerPhone, rotulo: 'Celular', dica: '(DDD) 91234-5678'),
          Editor(controlador: _controllerAddress, rotulo: 'Endereço', dica: 'Rua Silva, 840'),
          ElevatedButton(
            onPressed: () {
              _criarContato(context, _controllerCpf, _controllerName, _controllerEmail, _controllerPhone, _controllerAddress);
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
            child: const Text('Confirmar', style: TextStyle(color: Colors.white, fontSize: 18)),
          )
        ],
      ),
    );
  }

  void _criarContato(
    BuildContext context,
    TextEditingController controllerCpf,
    TextEditingController controllerName,
    TextEditingController controllerEmail,
    TextEditingController controllerPhone,
    TextEditingController controllerAddress,
    ) {
    final String? cpf = controllerCpf.text;
    final String? name = controllerName.text;
    final String? email = controllerEmail.text;
    final String? phone = controllerPhone.text;
    final String? address = controllerAddress.text;

    if (cpf != null && name != null && email != null && phone != null && address != null) {
      final contatoCriado = Contato(cpf, name, email, phone, address);
      Navigator.pop(context, contatoCriado);
    }
  }
}

class ListaTransferencia extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  ListaTransferencia({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Transferências", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          return ItemTransferencia(widget._transferencias[indice]);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioTransferencia()),
          );

          future.then((transferenciaRecebida) {
            if (transferenciaRecebida != null) {
              setState(() {
                widget._transferencias.add(transferenciaRecebida);
              });
            }
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(size: 35, color: Colors.white, Icons.add_circle_rounded),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;
  const ItemTransferencia(this._transferencia, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatMoney = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Card(
      child: ListTile(
        subtitle: Text(_transferencia.numeroConta.toString()),
        title: Text(formatMoney.format(_transferencia.valor)),
        leading: const Icon(Icons.monetization_on, color: Colors.green),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferência{valor: $valor, numeroConta: $numeroConta}';
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerCampoValor = TextEditingController();
  final TextEditingController _controllerCampoNumeroConta = TextEditingController();

  FormularioTransferencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Nova Transferência", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Editor(controlador: _controllerCampoNumeroConta, rotulo: 'Numero da conta', dica: '0000'),
          Editor(controlador: _controllerCampoValor, rotulo: 'Valor', dica: '0.00', icone: Icons.monetization_on),
          ElevatedButton(
            onPressed: () {
              _criarTransferencia(context, _controllerCampoNumeroConta, _controllerCampoValor);
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
            child: const Text('Confirmar', style: TextStyle(color: Colors.white, fontSize: 18)),
          )
        ],
      ),
    );
  }

  void _criarTransferencia(BuildContext context, TextEditingController controllerCampoNumeroConta, TextEditingController controllerCampoValor) {
    final int? numeroConta = int.tryParse(controllerCampoNumeroConta.text);
    final double? valor = double.tryParse(controllerCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final String? dica;
  final String? rotulo;
  final IconData? icone;
  final TextEditingController? controlador;

  const Editor({
    super.key,
    this.dica,
    this.icone,
    this.rotulo,
    this.controlador,
  });

  @override
  Widget build(BuildContext context) {

    final icon = this.icone != null ? Icon(icone, color: Colors.green) : null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(hintText: dica, labelText: rotulo, icon: icon),
      ),
    );
  }
}
