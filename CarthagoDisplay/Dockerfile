#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim-arm32v7 AS base
RUN apt-get update && apt-get install -y libgdiplus
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim-arm32v7 AS build
WORKDIR /src
COPY ["CarthagoDisplay/CarthagoDisplay.csproj", "CarthagoDisplay/"]
RUN dotnet restore "CarthagoDisplay/CarthagoDisplay.csproj"
COPY . .
WORKDIR "/src/CarthagoDisplay"
RUN dotnet build "CarthagoDisplay.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "CarthagoDisplay.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CarthagoDisplay.dll"]