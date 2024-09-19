# Usar la imagen base del SDK de .NET
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Crear una nueva aplicación Blazor
RUN dotnet new blazor -o BlazorApp

# Copiar los archivos locales necesarios al contenedor
COPY ./Home.razor ./BlazorApp/Components/Pages/Home.razor
COPY ./NavMenu.razor ./BlazorApp/Components/Layout/NavMenu.razor
COPY ./Pizzas.razor ./BlazorApp/Components/Pages/Pizzas.razor
COPY ./PizzaSpecial.cs ./BlazorApp/Data/PizzaSpecial.cs
COPY ./Pizza.cs ./BlazorApp/Data/Pizza.cs

# Exponer el puerto en el que correrá la aplicación
EXPOSE 5000

# Cambiar al directorio de la aplicación Blazor
WORKDIR /app/BlazorApp

# Ejecutar la aplicación usando dotnet run
CMD ["dotnet", "run", "--urls", "http://0.0.0.0:5000"]
