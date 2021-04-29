<img src="https://i.imgur.com/bjCwde7.png" width="180px" height="180px" alt="PIXIE">

# Pixie-Performance-Database
Gerenciador de pontos pixie performance

# Função
--//--

## Organização do repositório



## Organização da workfolder

Primeiro é necessário clonar o repositório para sua workfolder

   ```sh
   git clone https://github.com/Pixie-EJ/pixie-performance-database (nome da pasta)
   ```

Após isso basta apenas abrir o bash do git, ou o terminal do linux na pasta criada e selecionar o branch de desenvolvimento

   * Esse comando lista todos os branches disponíveis

      ```sh
      git branch -a
      ```
   
   <img src="https://i.imgur.com/1M2DyjR.png" width="" height="" alt="PIXIE">
   
   * Utilizamos o checkout para selecionar o branch staging (desenvolvimento)

      ```sh
      git checkout staging
      ```
   
Feito isso, é necessário criar um branch separado para cada modificação que será feita, pois é necessário aprovação para enviar códigos para o staging

   * O branch é criado e selecionado desta maneira

       ```sh
       git branch (nome do branch, ex: task-luan)
       ```
      
   * Logo após selecionamos o branch criado com:
   
       ```sh
       git checkout (nome do branch, ex: task-luan)
       ```
 
 Pronto! seu repositório local está preparado e organizado
 
 ## Atualizando o repositório local
 
 Normalmente quando uma task é completada e o merge/rebase é feito com o staging, o seu branch staging local ficará desatualizado em relação ao principal, para resolver isso é necessário atualizar seu repositório local com alguns comandos
 
   ```sh
   git checkout staging
   ```
   
   ```sh
   git pull
   ```
   
Evite fazer branches sem atualizar o staging local, pois atualizar evita o risco de conflitos na hora de realizar um pull-request

## Enviando alterações

Para enviar as alterações é recomendavel explicar o que foi feito nelas quando se faz um commit, utilize este template para as alterações:

   ```sh
   (nome do arquivo editado, ou local): "este é um exemplo de um commit"
   --> "este é um exemplo de um commit, este é um exemplo de um commit, este é um exemplo de um commit, este é um exemplo de um commit"
   ```

Após tudo pronto, pode enviar seu novo branch com as alterações utilizando o push

   ```sh
   git push
   ```
   
É comum o git pedir para você definir a upstream, simplemente digite o comando que o git mostrar na tela, no nosso caso será este:

   ```sh
   git push --set-upstream origin (nome do branch criado)
   ```
   
Pronto! código enviado!
