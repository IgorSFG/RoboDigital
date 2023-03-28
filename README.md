# Visão Geral do Robô Digital
O robô digital se baseia em uma simulação realizada na plataforma Godot. Ele se move por um sistema de coordenadas armazenadas em um banco de dados e enviadas por uma página web.
 
# Arquitetura do Sistema

## Diagrama Geral

![Diagrama](https://github.com/IgorSFG/RoboDigital/blob/main/img/Diagrama.jpg)

## Interface
A interface do projeto foi feita utilizando como base HTML e CSS e tem como objetivo:
- Possibilitar a adição de posições que o robô digital irá percorrer.
- Vizualizar as posições armazenadas no banco de dados.

![Interface](https://github.com/IgorSFG/RoboDigital/blob/main/img/Interface.jpg)

## Backend
O Backend do robô digital foi feito utilizando Flask com integração de um banco de dados SQLite. Ele foi criado tanto para acesso quanto envio de valores para o banco de dados, e também corresponder as solicitações do usuário.
- O endpoint "/" tem como método o "GET", nele o usuário recebe a página HTML junto com a vizualização das posições já armazenadas no banco de dados.
- Quando o usuário desejar enviar as posições do movimento do robô digital, ele solicitará o "/postPosition", endpoint responsável pelo método "POST", que adicionará os valores das posições no banco de dados.
- O "/positions" é o endpoint solicitado pela plataforma de simulação Godot, ele utiliza do método "GET" para obter os valores das posições armazenadas no banco de dados e os retorna em formato JSON. Ele é o responsável por possibilitar a leitura das posições pelo Godot.

## Banco de Dados
O banco de dados SQLite tem uma tabela "Robo" e tem como colunas os valores das poições: X, Y, Z, Rx, Ry, Rz.

![Tabela](https://github.com/IgorSFG/RoboDigital/blob/main/img/Tabela.jpg)

## Simulação
O sistema de simulação mostra uma representação tridimensional de uma cadeia cinemática de um robô. Para a implementação desse processo foi utilizada a engine Godot. A simulação realiza requisições para a API desenvolvida e atualiza a posição do robô junto a sua interface própria conforme os valores disponibilizados.

O vídeo da simulação pode ser visto em:
[Vídeo da Simulação](https://drive.google.com/file/d/1HY2firxby3nDeF3xuILg5oyQrxLZhb_1/view?usp=sharing)


