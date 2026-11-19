import 'package:flutter/material.dart';
import 'cadastro_peca_page.dart';

// Lista em memória (não persiste após fechar o app)
final List<Map<String, String>> pecas = [
  {'peca': 'Camiseta', 'tamanho': 'M', 'cor': 'Azul'},
  {'peca': 'Calça Jeans', 'tamanho': 'PP', 'cor': 'Azul Escuro'},
  {'peca': 'Vestido', 'tamanho': 'GG', 'cor': 'Vermelho'},
  {'peca': 'Jaqueta', 'tamanho': 'G', 'cor': 'Preta'},
  {'peca': 'Bermuda', 'tamanho': 'P', 'cor': 'Bege'},
];

class LojaPage extends StatefulWidget {
  const LojaPage({super.key});

  @override
  State<LojaPage> createState() {
    return _LojaPageState();
  }
}

class _LojaPageState extends State<LojaPage> {

  // Abre o formulário vazio (cadastro)
  Future<void> cadastrar() async {
    final novaPeca = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => const CadastroPecaPage(),
      ),
    );
    if (novaPeca != null && mounted) {
      setState(() {
        pecas.add(novaPeca);
      });
    }
  }

  // Abre o formulário preenchido (edição) e substitui na mesma posição
  Future<void> editar(int index) async {
    final pecaEditada = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroPecaPage(peca: pecas[index]),
      ),
    );
    if (pecaEditada != null && mounted) {
      setState(() {
        pecas[index] = pecaEditada; // substitui, não duplica
      });
    }
  }

  // Confirma e remove
  void excluir(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Peça'),
        content: Text('Deseja excluir a peça ${pecas[index]['peca']!}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                pecas.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Loja de Roupas'),
      ),
      body: pecas.isEmpty
          ? const Center(child: Text('Nenhuma peça cadastrada.'))
          : ListView.builder(
        itemCount: pecas.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => editar(index),
            leading: const Icon(Icons.checkroom),
            title: Text(pecas[index]['peca']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tamanho: ${pecas[index]['tamanho']!}'),
                Text('Cor: ${pecas[index]['cor']!}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => excluir(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cadastrar,
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Loja de Roupas',
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
    ),
    home: const LojaPage(),
  ));
}