# Etapa de compilación - Utilizando la imagen SDK de .NET
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Variables para los directorios y archivos del proyecto
ARG WORKDIR="/app"
ARG BLAZING_PIZZA_DIR="${WORKDIR}/BlazingPizza"
ARG BLAZOR_PROJECT="BlazingPizza"

# Configurando el directorio de trabajo
WORKDIR $WORKDIR

# Copia el proyecto BlazingPizza
COPY ./BlazingPizza/ $BLAZING_PIZZA_DIR/

# Copia archivos personalizados al proyecto
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

# Exponer el puerto de la aplicación
EXPOSE 5000

# Configurar el directorio de trabajo para ejecutar la aplicación Blazor
WORKDIR $BLAZING_PIZZA_DIR

# Ejecutar la aplicación con dotnet
CMD ["dotnet", "run", "--urls", "http://0.0.0.0:5000"]
