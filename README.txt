Kablink Simulado com Docker - Java 8 + Tomcat 8

COMANDOS PARA RODAR:

1. Build da imagem:
   docker build -t kablink-local .

2. Rodar o container:
   docker run -d -p 8080:8080 --name kablink-app kablink-local

3. Acessar no navegador:
   http://localhost:8080/webserv/relatorios/teste.jsp
