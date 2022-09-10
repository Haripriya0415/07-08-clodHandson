
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443 

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["07-08-clodHandson/07-08-clodHandson.csproj", "07-08-clodHandson/"]
RUN dotnet restore "07-08-clodHandson/07-08-clodHandson.csproj"
COPY . .
WORKDIR "/src/07-08-clodHandson"
RUN dotnet build "07-08-clodHandson.csproj" -c Release -o /app/build 
FROM build AS publish
RUN dotnet publish "07-08-clodHandson.csproj" -c Release -o /app/publish 
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "07-08-clodHandson.dll"]
 