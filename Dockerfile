# Usa la imagen base
FROM cesarbm/microsoft_net_8

# Establece el directorio de trabajo en /app
WORKDIR /app

# Instala la plantilla de Blazor
RUN dotnet new blazor -o BlazingPizza

# Establece el directorio de trabajo en /app/BlazingPizza
WORKDIR /app/BlazingPizza

# Copia todos los archivos al contenedor
COPY . .

# Expone el puerto 80 para que la app sea accesible desde fuera del contenedor
EXPOSE 80

# Comando para iniciar la aplicación cuando el contenedor se ejecute
CMD ["dotnet", "run", "--urls", "http://0.0.0.0:80"]
