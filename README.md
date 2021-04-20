# Desafio iOS - News

## Como será o desafio

Utilizando a [NEWS API](https://documenter.getpostman.com/view/8211335/SzKbLFAY), você deverá criar um app de notícias. O usuário irá visualizar no topo da tela, um carrossel das notícias em destaques e abaixo uma listagem corrida com as notícias, ordenadas pela data de publicação, podendo salvar como favorito a notícia desejada;
O usuário só vai poder acessar a tela de Feed autenticado.

## Features

Tela de Login (Opcional)   
 - Email e Password.

Tela de Cadastro (Obrigatória)
- E-mail;
- Senha;
- Confirmação de senha.

Tela de Feed (Obrigatória)
- O usuário irá visualizar no topo da tela, um carrossel das notícias em destaques;
- O usuário irá visualizar uma listagem corrida com as notícias, ordenadas pela data de publicação;
- O usuário poderá salvar como favorito a notícia desejada;
- Cada notícia deve conter:
- Imagem;
- Título (Máximo de 2 linhas);
- Descrição (Máximo de 2 linhas);
- Botão para favoritar/desfavoritar.
- O usuário só vai poder acessar a tela de Feed autenticado.

Funcionalidades Extras:
- Atualização das notícias de 30 em 30 segundos;
- Compartilhar notícias.


O Que Usar: 
- MVVM / MVP;
- A utilização de biblioteca de terceiros é permitida;
- Swift ou Kotlin.

Diferencial:
- SwiftLint, Alamofire, Codable, Testes, Injeção de dependências.

---

## Api

[Documentação](https://documenter.getpostman.com/view/8211335/SzKbLFAY)

É utilizado de tokens para controle de sessão, as requisições que necessitam que o usuário esteja logado precisará passar o token com a chave`Authorization` no header.

Token: `eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU5LCJlbWFpbCI6ImRpbWFzLmdhYnJpZWxAenJvYmFuay5jb20uYnIifQ.a3j7sRx8FIedZCfDGLocduOYpcibfIenX7TVJjv6Sis`

---

## Layout

<img src="Assets/Screen Shot 1 - iPhone 11.png"
alt="" width="375" height="812" border="1" /> | <img src="Assets/Screen Shot 2 - iPhone 11.png"
alt="" width="375" height="812" border="1" />

<img src="Assets/Screen Shot 3 - iPhone 11.png"
alt="" width="375" height="812" border="1" /> | <img src="Assets/Screen Shot 4 - iPhone 11.png"
alt="" width="375" height="812" border="1" />

<img src="Assets/Screen Shot 5 - iPhone 11.png"
alt="" width="375" height="812" border="1" /> | <img src="Assets/Screen Shot 6 - iPhone 11.png"
alt="" width="375" height="812" border="1" />

---
