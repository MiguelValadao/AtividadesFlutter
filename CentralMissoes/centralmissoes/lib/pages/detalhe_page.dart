import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/missao.dart';
import '../providers/missao_provider.dart';

class DetalhePage extends StatelessWidget {
  final Missao missao;

  const DetalhePage({super.key, required this.missao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETALHES DA MISSÃO'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título: ${missao.titulo}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(
              'Dificuldade: ${Missao.estrelas(missao.dificuldade)} ${missao.dificuldade}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text('Pontos: ${missao.pontos}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Text(
              'Status: ${missao.concluida ? 'Concluída' : 'Pendente'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (missao.data.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Data: ${missao.data}',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
            const SizedBox(height: 32),
            if (!missao.concluida)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<MissaoProvider>().concluir(missao);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Missão concluída!\nVocê conquistou ${missao.pontos} pontos.',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('CONCLUIR MISSÃO'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
