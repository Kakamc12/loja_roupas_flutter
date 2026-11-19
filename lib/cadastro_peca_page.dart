import 'package:flutter/material.dart';

class CadastroPecaPage extends StatefulWidget {
  // Se for null => cadastro novo. Se vier preenchido => edição.
  final Map<String, String>? peca;
  const CadastroPecaPage({super.key, this.peca});

  @override
  State<CadastroPecaPage> createState() {
    return _CadastroPecaPageState();
  }
}

class _CadastroPecaPageState extends State<CadastroPecaPage> {

  final pecaController = TextEditingController();
  final tamanhoController = TextEditingController();
  final corController = TextEditingController();

  bool get editando => widget.peca != null;

  @override
  void initState() {
    super.initState();
    if (widget.peca != null) {
      pecaController.text = widget.peca!['peca'] ?? '';
      tamanhoController.text = widget.peca!['tamanho'] ?? '';
      corController.text = widget.peca!['cor'] ?? '';
    }
  }

  @override
  void dispose() {
    pecaController.dispose();
    tamanhoController.dispose();
    corController.dispose();
    super.dispose();
  }

  void salvar() {
    String peca = pecaController.text.trim();
    String tamanho = tamanhoController.text.trim();
    String cor = corController.text.trim();

    // Validação: vazio ou apenas espaços
    if (peca.isEmpty || tamanho.isEmpty || cor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Atenção! Todos os campos são obrigatórios!'),
        ),
      );
      return;
    }

    // Devolve o registro para a tela anterior
    Navigator.pop(context, {
      'peca': peca,
      'tamanho': tamanho,
      'cor': cor,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(editando ? 'Editar Peça' : 'Cadastro de Peça'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            TextField(
              controller: pecaController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Peça',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16.0),
            TextField(
              controller: tamanhoController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Tamanho',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16.0),
            TextField(
              controller: corController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Cor',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: salvar,
                child: const Text('Salvar'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}