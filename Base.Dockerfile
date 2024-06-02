FROM mcr.microsoft.com/dotnet/sdk:8.0

WORKDIR /app
ADD . /app/

RUN apt upgrade -y
RUN apt update -y

RUN dotnet dev-certs https --trust

RUN dotnet restore
RUN dotnet build
RUN dotnet publish

# CMD ["dotnet", "Main/Apps/Api/bin/Release/net8.0/Api.dll"]
