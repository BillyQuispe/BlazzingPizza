

# Usa la imagen base de .NET SDK para la fase de compilación
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Establece el directorio de trabajo
WORKDIR /home

# Clona el repositorio de BlazingPizza
RUN git clone https://github.com/MicrosoftDocs/mslearn-blazor-navigation.git BlazingPizza

# Cambia al directorio del proyecto BlazingPizza
WORKDIR /home/BlazingPizza

# Copia los archivos de reemplazo 
COPY ./BlazingPizza/ ./home/BlazingPizza/
COPY ./Checkout.razor ./home/BlazingPizza/Pages/Checkout.razor
COPY ./Index.razor ./home/BlazingPizza/Pages/Index.razor
COPY ./OrderController.cs ./home/BlazingPizza/OrderController.cs
COPY ./OrderState.cs ./home/BlazingPizza/OrderState.cs
COPY ./PizzaStoreContext.cs ./home/BlazingPizza/PizzaStoreContext.cs
COPY ./MyOrders.razor ./home/BlazingPizza/Pages/MyOrders.razor
COPY ./OrderDetail.razor ./home/BlazingPizza/Pages/OrderDetail.razor
COPY ./MainLayout.razor ./home/BlazingPizza/Shared/MainLayout.razor
COPY ./App.razor ./home/BlazingPizza/App.razor
COPY ./_Host.cshtml ./home/BlazingPizza/Pages/_Host.cshtml

# Restaura las dependencias del proyecto
RUN dotnet restore

# Compila y publica la aplicación
RUN dotnet publish -c Release -o /app

# Usa la imagen base de .NET Runtime para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Establece el directorio de trabajo en la nueva imagen
WORKDIR /app

# Copia la aplicación compilada desde la fase de build
COPY --from=build /app .

# Expone los puertos 80 y 443
EXPOSE 80
EXPOSE 443

# Define el punto de entrada para ejecutar la aplicación
ENTRYPOINT ["dotnet", "BlazingPizza.dll"]