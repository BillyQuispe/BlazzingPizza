# Usa la imagen base de .NET SDK
FROM mcr.microsoft.com/dotnet/sdk:6.0

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo de solución y restaura las dependencias
COPY BlazingPizza/BlazingPizza.csproj BlazingPizza/
RUN dotnet restore "BlazingPizza/BlazingPizza.csproj"

# Copia el resto del código
COPY BlazingPizza/. BlazingPizza/

# Expone el puerto 80 para que la app sea accesible
EXPOSE 80

# Comando para iniciar la aplicación
CMD ["dotnet", "run", "--project", "BlazingPizza/BlazingPizza.csproj", "--urls", "http://0.0.0.0:80"]
