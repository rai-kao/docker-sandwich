# Docker Sandwich :sandwich:

Install development services using Docker Compose

## Prerequisites
- Install [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/)
- :coffee:
- Additional requirements for Windows system
  * WSL kernel version 5.8 or above, see [kernel](#update-kernel-version)
  * Configure max map count to meet Elasticsearch requirements, see [mmap](#configure-mmap-count)

## Docker-in-Docker(Optional)
This step will install services using Docker-in-Docker(dind). If you only need to install services, please see [Linux](#linux) or [Windows](#windows).
- Install CentOS 7 Docker image
  ```
  cd docker-sandwich
  docker-compose up -d
  ```

## Install Services
The following steps will install below services based on your system.
- FastDFS: latest
- Kafka: 3.1
- Nacos: 2.0.4
- Sentinel: 1.7.0
- Storm: 2.3
- MySQL: 8
- MongoDB: latest
- Redis: 6
- SonarQube: 9.3-community

#### Linux Container(dind)
- Enter docker container
  ```
  docker exec -it sandwich bash
  ```
- Navigate to the docker compose file directory
  ```
  cd /home/dind
  ```
- Modify default settings
  ```
  vi default.env
  ```
- Install all services
  ```
  ./service-start.sh
  ```
  :coffee:
- Install single service
  ```
  cd [service]
  docker-compose up -d
  ```

#### Linux <a name="linux"></a>
- Navigate to the dind directory
  ```
  cd c7-systemd/dind
  ```
- Modify default settings
  ```
  vi default.env
  ```
- Install all services
  ```
  ./service-start.sh
  ```
  :coffee:
- Install single service
  ```
  cd [service]
  docker-compose up -d
  ```

#### Windows <a name="windows"></a>
- Navigate into the dind directory
  ```
  cd c7-systemd/dind
  ```
- Modify default settings
  ```
  notepad default.env
  ```
- Install all services
  ```
  ./service-start.sh
  ```
  :coffee:
- Install single service
  ```
  cd [service]
  docker-compose up -d
  ```
  
## WSL Configuration
Windows Subsystem for Linux configurations

#### Update Kernel Version <a name="update-kernel-version"></a>
- Check WSL version information
  ```
  wsl --status
  ```
- Update WSL kernel version
  ```
  wsl --update
  ```
  
#### Configure mmap count <a name="configure-mmap-count"></a>
> WSL2 default vm.max_map_count is 65530. Elasticsearch requires at least 262144.
- Modify .wslconfig
  ```
  notepad "$env:USERPROFILE/.wslconfig"
  ```
- Add max heap count value
    ```
    [wsl2]
    kernelCommandLine = sysctl.vm.max_map_count=262144 # Additional kernel command line arguments.
    ```
- Restart WSL
  * Open powershell with admin privileges
  ```
  Get-Service LxssManager | Restart-Service
  ```

#### Reduce WSL Resource Consumption
> WSL2 consumes up to 50% of your total system memory by default.
- Modify WSL memory usage
  ```
  wsl -shutdown
  notepad "$env:USERPROFILE/.wslconfig"
  ```
- .wslconfig
    ```
    [wsl2]
    memory=4GB   # How much memory to assign to the WSL2 VM.
    processors=2 # How many processors to assign to the WSL2 VM.
    swap=0       # How much swap space to add to the WSL2 VM. 0 for no swap file.
    ```
- For other settings please see [Advanced settings configuration in WSL](https://docs.microsoft.com/en-us/windows/wsl/wsl-config)
- Restart WSL or Docker Desktop
  
#### Exclude Ports Reserved by WSL
> WSL2 reserves a huge amount of ports which may conflict with applications.
- List reserved Ports
  ```
  netsh int ipv4 show excludedportrange protocol=tcp
  ```
- Disable Hyper-V (Restart Windows)
  ```
  dism.exe /Online /Disable-Feature:Microsoft-Hyper-V
  ```
- Exclude application ports
  ```
  netsh int ipv4 add excludedportrange protocol=tcp startport=49772 numberofports=2
  ```
- Enable Hyper-V (Restart Windows)
  ```
  dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All
  ```