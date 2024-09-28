Dashboard Flutter: Contatos e Transferências
Este projeto consiste em um dashboard desenvolvido em Flutter com duas principais telas: "Contatos" e "Transferências". A aplicação permite o cadastro e manipulação de clientes, além de operações de transferência entre eles, utilizando uma estrutura de dados dinâmica (Lista de Array) conforme visto em sala de aula.

Tabela de Conteúdos
Visão Geral
Funcionalidades
Instalação
Estrutura do Projeto
Tecnologias Utilizadas
Licença
Visão Geral
O projeto foi construído para permitir a visualização e manipulação de contatos, além da execução de transferências entre eles. A tela de entrada é o dashboard, com dois links principais:

Contatos: Permite o cadastro e visualização de uma lista de contatos. Cada contato possui os seguintes atributos:

Nome
Endereço
Telefone
E-mail
CPF
Transferências: Permite realizar transferências entre os contatos cadastrados, com alterações no design para facilitar a usabilidade.

Funcionalidades
Cadastro de Contatos: Adicione, visualize e gerencie contatos. Cada contato inclui nome, endereço, telefone, e-mail e CPF.
Lista de Contatos: Visualize todos os contatos cadastrados.
Transferências: Realize transferências entre contatos utilizando uma interface simples e intuitiva.
Navegação entre Telas: A interação entre as telas "Contatos" e "Transferência" é feita através de navegação em um dashboard.
Instalação
Pré-requisitos
Certifique-se de ter o Flutter instalado em sua máquina. Para mais detalhes, consulte a documentação oficial do Flutter.

Passos para Instalação
Clone o repositório:

bash
Copiar código
git clone <URL_DO_REPOSITORIO>
Acesse o diretório do projeto:

bash
Copiar código
cd nome-do-projeto
Instale as dependências:

bash
Copiar código
flutter pub get
Execute o projeto:

bash
Copiar código
flutter run
Estrutura do Projeto
A estrutura do projeto é baseada em uma arquitetura simples com organização em telas (pages) e widgets reutilizáveis.

bash
Copiar código
lib/
│
├── models/               # Contém os modelos de dados (ex.: Contato)
├── pages/                # Contém as telas de Contatos, Transferências e Dashboard
├── widgets/              # Componentes reutilizáveis
└── main.dart             # Arquivo principal de execução da aplicação
Tecnologias Utilizadas
Flutter - Framework para desenvolvimento mobile multiplataforma.
Dart - Linguagem de programação utilizada pelo Flutter.
Licença
Este projeto é licenciado sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

