FROM mcr.microsoft.com/dotnet/sdk:8.0

WORKDIR /app
ADD . /app/
EXPOSE 8000

RUN apt upgrade -y
RUN apt update -y

# CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "80"]
