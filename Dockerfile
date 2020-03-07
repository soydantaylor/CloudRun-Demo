FROM mcr.microsoft.com/dotnet/core/sdk:3.0 as build
WORKDIR /build
#add other .csproj here as they get added
COPY ./StatusUpdater/StatusUpdater.csproj ./StatusUpdater/StatusUpdater.csproj
COPY StatusUpdater.sln .
RUN dotnet restore StatusUpdater.sln

COPY . .
RUN dotnet publish StatusUpdater.sln -c Release -o /publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 as runtime
WORKDIR /app
USER root

RUN useradd -ms /bin/bash dotnetuser \
&& chown dotnetuser /app 
USER dotnetuser
COPY --from=build /publish .
ENTRYPOINT ["dotnet", "/app/StatusUpdater.dll"]