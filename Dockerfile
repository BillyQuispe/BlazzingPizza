# Usa la imagen base de .NET SDK
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Establece el directorio de trabajo
WORKDIR /src

# Clona el repositorio
RUN git clone https://github.com/MicrosoftDocs/mslearn-interact-with-data-blazor-web-apps.git BlazingPizza

# Copia el archivo de solución y restaura las dependencias
WORKDIR /src/BlazingPizza
RUN dotnet restore "BlazingPizza.csproj"

# Construye la aplicación
RUN dotnet build "BlazingPizza.csproj" -c Release -o /app/build

# Publica la aplicación
RUN dotnet publish "BlazingPizza.csproj" -c Release -o /app/publish

# Usa la imagen base de .NET Runtime para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Expone el puerto 80 para que la app sea accesible
EXPOSE 80

# Comando para iniciar la aplicación
CMD ["dotnet", "BlazingPizza.dll"]
