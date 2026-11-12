import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/missao.dart';
import '../providers/missao_provider.dart';
import 'detalhe_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tituloController = TextEditingController();
  String _dificuldade = 'Fácil';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MissaoProvider>().carregarMissoes();
    });
  }

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    final titulo = _tituloController.text.trim();
    if (titulo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o título da missão.')),
      );
      return;
    }

    context.read<MissaoProvider>().cadastrar(
          titulo: titulo,
          dificuldade: _dificuldade,
        );

    _tituloController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Missão cadastrada!')),
    );
  }

  void _concluir(Missao missao) {
    context.read<MissaoProvider>().concluir(missao);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Missão concluída!\nVocê conquistou ${missao.pontos} pontos.',
        ),
      ),
    );
  }

  void _excluir(Missao missao) {
    context.read<MissaoProvider>().excluir(missao);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Missão excluída!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CENTRAL DE MISSÕES'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<MissaoProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'PONTOS CONQUISTADOS: ${provider.totalPontos}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    TextField(
                      controller: _tituloController,
                      decoration: const InputDecoration(
                        labelText: 'Título da missão',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _dificuldade,
                      decoration: const InputDecoration(
                        labelText: 'Dificuldade',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Fácil', child: Text('Fácil')),
                        DropdownMenuItem(value: 'Médio', child: Text('Médio')),
                        DropdownMenuItem(
                            value: 'Difícil', child: Text('Difícil')),
                      ],
                      onChanged: (valor) {
                        if (valor != null) {
                          setState(() => _dificuldade = valor);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _cadastrar,
                        child: const Text('CADASTRAR MISSÃO'),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: provider.carregando
                    ? const Center(child: CircularProgressIndicator())
                    : provider.missoes.isEmpty
                        ? const Center(
                            child: Text('Nenhuma missão cadastrada.'))
                        : ListView.builder(
                            itemCount: provider.missoes.length,
                            itemBuilder: (context, index) {
                              final missao = provider.missoes[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DetalhePage(
                                          missao: missao,
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(missao.titulo),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dificuldade: ${Missao.estrelas(missao.dificuldade)}',
                                      ),
                                      Text('Pontos: ${missao.pontos}'),
                                      Text(
                                        'Status: ${missao.concluida ? 'Concluída' : 'Pendente'}',
                                      ),
                                      if (missao.data.isNotEmpty)
                                        Text('Data: ${missao.data}'),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (!missao.concluida)
                                        TextButton(
                                          onPressed: () => _concluir(missao),
                                          child: const Text('CONCLUIR'),
                                        ),
                                      TextButton(
                                        onPressed: () => _excluir(missao),
                                        child: const Text('EXCLUIR'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}
