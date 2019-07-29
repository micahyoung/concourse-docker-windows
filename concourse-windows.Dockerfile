FROM mcr.microsoft.com/windows/servercore:1809

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Invoke-WebRequest -UseBasicParsing https://github.com/concourse/concourse/releases/download/v5.4.0/concourse-5.4.0-windows-amd64.zip -OutFile concourse.zip ; Expand-Archive concourse.zip ; Move-Item .\concourse\concourse\bin\concourse.exe concourse.exe ; Remove-Item -Recurse -Force -Path .\concourse\,concourse.zip

RUN New-Item -Type Directory -Path "c:\\work"

SHELL ["cmd.exe", "/c"]

ENTRYPOINT [ "c:\\concourse.exe" ]

# work
COPY secrets secrets
