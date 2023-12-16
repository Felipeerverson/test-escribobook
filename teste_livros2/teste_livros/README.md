Flutter Livros App
Este é um aplicativo Flutter simples para exibir uma lista de livros a partir de uma API e permitir o download dos mesmos. Além disso, o aplicativo oferece uma página de favoritos para marcar os livros preferidos.

Recursos
Página Inicial: Apresenta uma lista de livros em um formato de grade. Cada livro exibe sua capa, ID, título e um botão para iniciar o download.

Página de Favoritos: Ao clicar no botão "Página Favoritos" na barra de navegação, você é direcionado para uma nova página que permite visualizar e gerenciar os livros marcados como favoritos.

Como Usar
Clone o repositório para sua máquina local.
git clone https://github.com/seu-usuario/teste_livros.git
Abra o projeto no seu editor de código preferido.

Execute o aplicativo em um emulador ou dispositivo físico.
flutter run
Dependências
O aplicativo utiliza as seguintes dependências:

flutter/material.dart: Para a criação da interface do usuário.
http: Para fazer requisições HTTP e obter dados da API.
url_launcher: Para abrir URLs externas para download dos livros.
Estrutura do Projeto
lib/main.dart: Contém a definição da classe HomePage que representa a tela inicial do aplicativo.

lib/favoritos.dart: Contém a definição da classe FavoritosPage que representa a tela de favoritos.

API Utilizada
O aplicativo consome dados de uma API pública de livros hospedada em https://escribo.com/books.json.

Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir problemas, propor melhorias ou enviar solicitações de pull.





