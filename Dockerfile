FROM mcr.microsoft.com/dotnet/core/sdk:3.0 as build
WORKDIR /build

#add other .csproj here as they get added
COPY ./CloudRunDemo/CloudRunDemo.csproj ./CloudRunDemo/CloudRunDemo.csproj
COPY CloudRunDemo.sln .
RUN dotnet restore CloudRunDemo.sln

COPY . .
RUN dotnet publish CloudRunDemo.sln -c Release -o /publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 as runtime
WORKDIR /app
USER root

RUN useradd -ms /bin/bash dotnetuser \
&& chown dotnetuser /app 
USER dotnetuser
COPY --from=build /publish .
CMD ["dotnet", "CloudRunDemo.dll"]