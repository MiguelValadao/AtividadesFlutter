Cadastro de Feiticeiros
A Escola Jujutsu precisa de um aplicativo para organizar os feiticeiros cadastrados.
O aplicativo deverá utilizar:
Flutter
Firebase Authentication
Cloud Firestore
Login com Google
Ao abrir o aplicativo:
Usuário logado?

NÃO
↓
Tela de Login

SIM
↓
Central Jujutsu
Na tela de login:
ESCOLA JUJUTSU

Acesso restrito para feiticeiros

[ ENTRAR COM GOOGLE ]
Depois do login, mostre:
Foto do usuário

Bem-vindo,
[nome do usuário]

[email]
Na Central Jujutsu, o usuário poderá cadastrar missões.
Cada missão deverá possuir:
titulo
grau
concluida
usuarioId
Exemplo:
Título:
Investigar maldição na escola

Grau:
2

Concluída:
false
O campo:
usuarioId
deverá receber o uid do usuário autenticado:
FirebaseAuth.instance.currentUser!.uid
O aplicativo deverá permitir:
Cadastrar missão
Listar missões
Marcar missão como concluída
Excluir missão
Sair da conta
Regra principal
Cada feiticeiro deverá visualizar somente as missões cadastradas por ele.
Exemplo:
USUÁRIO 1
uid: ABC123

Missão:
Investigar maldição
usuarioId: ABC123


USUÁRIO 2
uid: XYZ999

Missão:
Proteger escola
usuarioId: XYZ999
Se o usuário ABC123 estiver logado:
Investigar maldição
Ele não deverá visualizar:
Proteger escola
