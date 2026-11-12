class Missao {
  String? id;
  String titulo;
  String dificuldade;
  int pontos;
  bool concluida;
  String data;

  Missao({
    this.id,
    required this.titulo,
    required this.dificuldade,
    required this.pontos,
    this.concluida = false,
    this.data = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'dificuldade': dificuldade,
      'pontos': pontos,
      'concluida': concluida,
      'data': data,
    };
  }

  factory Missao.fromMap(Map<String, dynamic> map, {String? id}) {
    return Missao(
      id: id,
      titulo: map['titulo'] ?? '',
      dificuldade: map['dificuldade'] ?? '',
      pontos: map['pontos'] ?? 0,
      concluida: map['concluida'] ?? false,
      data: map['data'] ?? '',
    );
  }

  static int pontosPorDificuldade(String dificuldade) {
    switch (dificuldade) {
      case 'Fácil':
        return 10;
      case 'Médio':
        return 20;
      case 'Difícil':
        return 30;
      default:
        return 0;
    }
  }

  static String estrelas(String dificuldade) {
    switch (dificuldade) {
      case 'Fácil':
        return '⭐';
      case 'Médio':
        return '⭐⭐';
      case 'Difícil':
        return '⭐⭐⭐';
      default:
        return '';
    }
  }
}
