import 'package:flutter_test/flutter_test.dart';

import 'package:centralmissoes/models/missao.dart';

void main() {
  test('Pontos definidos pela dificuldade', () {
    expect(Missao.pontosPorDificuldade('Fácil'), 10);
    expect(Missao.pontosPorDificuldade('Médio'), 20);
    expect(Missao.pontosPorDificuldade('Difícil'), 30);
  });

  test('toMap e fromMap convertem a missão', () {
    final missao = Missao(
      titulo: 'Estudar Firebase',
      dificuldade: 'Difícil',
      pontos: 30,
      concluida: false,
      data: '23/09/2026',
    );

    final map = missao.toMap();
    final outra = Missao.fromMap(map);

    expect(outra.titulo, 'Estudar Firebase');
    expect(outra.dificuldade, 'Difícil');
    expect(outra.pontos, 30);
    expect(outra.concluida, false);
    expect(outra.data, '23/09/2026');
  });
}
