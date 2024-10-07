# Etapa 1: Compilación - Utilizando la imagen SDK de .NET para construir el proyecto
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Variables para los directorios y archivos del proyecto
ARG WORKDIR="/app"
ARG BLAZING_PIZZA_DIR="${WORKDIR}/BlazingPizza"
ARG BLAZOR_PROJECT="BlazingPizza"

# Establece el directorio de trabajo
WORKDIR $WORKDIR

# Copia el proyecto BlazingPizza al contenedor
COPY ./BlazingPizza/ $BLAZING_PIZZA_DIR/

# Copia los archivos modificados necesarios
COPY ./Checkout.razor $BLAZING_PIZZA_DIR/Pages/Checkout.razor
COPY ./Index.razor $BLAZING_PIZZA_DIR/Pages/Index.razor
COPY ./OrderController.cs $BLAZING_PIZZA_DIR/OrderController.cs
COPY ./OrderState.cs $BLAZING_PIZZA_DIR/OrderState.cs
COPY ./PizzaStoreContext.cs $BLAZING_PIZZA_DIR/PizzaStoreContext.cs
COPY ./MyOrders.razor $BLAZING_PIZZA_DIR/Pages/MyOrders.razor
COPY ./OrderDetail.razor $BLAZING_PIZZA_DIR/Pages/OrderDetail.razor
COPY ./MainLayout.razor $BLAZING_PIZZA_DIR/Shared/MainLayout.razor
COPY ./App.razor $BLAZING_PIZZA_DIR/App.razor
COPY ./_Host.cshtml $BLAZING_PIZZA_DIR/Pages/_Host.cshtml

# Restaura las dependencias y paquetes NuGet del proyecto
RUN dotnet restore $BLAZING_PIZZA_DIR/BlazingPizza.csproj

# Compila la aplicación en modo Release y empaqueta en la carpeta /app/publish
RUN dotnet publish $BLAZING_PIZZA_DIR/BlazingPizza.csproj -c Release -o /app/publish

# Etapa 2: Imagen de ejecución - Utiliza la imagen base de .NET Runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

# Variables para el directorio de trabajo
ARG WORKDIR="/app"
ARG PUBLISH_DIR="/app/publish"

# Establece el directorio de trabajo en la nueva imagen
WORKDIR $WORKDIR

# Copia los archivos compilados desde la etapa de construcción
COPY --from=build $PUBLISH_DIR .

# Exponer el puerto en el que correrá la aplicación
EXPOSE 5000

# Ejecutar la aplicación compilada
ENTRYPOINT ["dotnet", "BlazingPizza.dll"]
