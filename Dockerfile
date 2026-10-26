FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /source
COPY server/server.csproj server/
RUN dotnet restore server/server.csproj
COPY server/ server/
RUN dotnet publish server/server.csproj -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000
ENTRYPOINT ["dotnet", "server.dll"]