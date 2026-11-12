import 'package:flutter/material.dart';

import '../models/missao.dart';
import '../services/missao_service.dart';

class MissaoProvider extends ChangeNotifier {
  final MissaoService _service = MissaoService();

  List<Missao> _missoes = [];
  bool _carregando = false;

  List<Missao> get missoes => _missoes;
  bool get carregando => _carregando;

  int get totalPontos => _missoes
      .where((m) => m.concluida)
      .fold(0, (soma, m) => soma + m.pontos);

  Future<void> carregarMissoes() async {
    _carregando = true;
    notifyListeners();

    _missoes = await _service.buscarTodas();

    _carregando = false;
    notifyListeners();
  }

  Future<void> cadastrar({
    required String titulo,
    required String dificuldade,
  }) async {
    final missao = Missao(
      titulo: titulo,
      dificuldade: dificuldade,
      pontos: Missao.pontosPorDificuldade(dificuldade),
      concluida: false,
      data: _dataAtual(),
    );

    await _service.adicionar(missao);
    await carregarMissoes();
  }

  Future<void> concluir(Missao missao) async {
    missao.concluida = true;
    await _service.atualizar(missao);
    await carregarMissoes();
  }

  Future<void> excluir(Missao missao) async {
    if (missao.id != null) {
      await _service.excluir(missao.id!);
    }
    await carregarMissoes();
  }

  String _dataAtual() {
    final agora = DateTime.now();
    String doisDigits(int valor) => valor.toString().padLeft(2, '0');
    return '${doisDigits(agora.day)}/${doisDigits(agora.month)}/${agora.year}';
  }
}
