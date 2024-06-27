# Docker Tutorial :whale: - the way to your own Docker Container :partying_face:

## We install the Docker engine

### 1. Set up Docker `apt` repository

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

#### **NOTE** If you use an Ubuntu derivative distro, such as Linux Mint, you may need to use **UBUNTU_CODENAME** instead of **VERSION_CODENAME**

### 2. Install the Docker packages

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 3. Verify your Success :100:

```bash
sudo docker run hello-world
```

### Post installation cheese :cheese:

#### After installing you may notice that you need to write `sudo` everytime you want to do something. That gets very tedious very fast. So I recommend to give docker root privileges. This could potentially be a **security risk**, so ask your **ADMIN** for the okay :ok_hand: if you are unsure

#### If you want to get rid of the `sudo` grind 

#### 1. Create the `docker` group

```bash
sudo groupadd docker
```

#### 2. Add tou user to the `docker` group :pinched_fingers:

```bash
sudo usermod -aG docker $USER
```

#### 3. Log out and back in for the changes to take effect or simply write :wink:

```bash
newgrp docker
```

#### 4. Verify your Success :heart_eyes:

```bash
docker run hello-world
```

## The easy but type heavy way

### Now that Docker is setup we can start by running our first real Container. A lot of Containers can be found at [Docker Hub](https://hub.docker.com/). We can run Docker Containers with a very easy command from the command line

```bash
docker run -itd <container name>
```

### Hereby the options `-itd` stand for **interactive, allocate a pseudo-TTY** and **detach**. We can also run specific versions of a Container using

```bash
docker run -itd <container name>:<version number>
```

### So for example if we want to launch a specific Linux distro, let's say Ubuntu 20.04. We can write

```bash
docker run -itd ubuntu:20.04
```

### **NOTE** we have now launched a Docker Container, but maybe you are wondering why we are not inside the Container yet? Check if the Container is running by using

```bash
docker ps -a
```

### You should see something like this

```bash
CONTAINER ID   IMAGE          COMMAND       CREATED          STATUS                   PORTS     NAMES
15f76074d4b8   ubuntu:20.04   "/bin/bash"   31 minutes ago   Up 3 seconds                       serene_bohr
67476b94c5b2   hello-world    "/hello"      7 hours ago      Exited (0) 7 hours ago             angry_banach
```

### If you Container is running - nice good job! If not we need to start it by

```bash
docker start -ia <container name>
```

### check again wirh the `docker ps -a` command. If you Container is up - great if not we have trouble :angry:

### If you Container is up attach to it using

```bash
docker attach <container name>
```

### If you successfully attached you can just start your coding shenanigans as usual on this fresh Container :peach:

### If your Container is not running and not really responding you may check the **COMMAND** section in the `docker ps -a` output. If the Container is first started by the `run` action and its **COMMAND** is for example "/hello", then the Container will start and run this Command and afterwards close, because it has finished its function

## Your own Docker Image

### We took a look at the installation process and the first run of an Image :white_check_mark:. But what if we want something of our own since a fresh image is quite tidious to set up every time. So now lets make `Dockerfile`

```bash
touch Dockerfile
```

### Afterwards we take a look inside the file using a text editor 

```bash
vim Dockerfile
```

### Inside the `DOCKERFILE` we write some cool stuff to initialize our Docker image

```bash
FROM ubuntu:22.04

WORKDIR /home/

COPY /home/ace/Documents .

RUN apt update && \
    apt install -y vim && \
    apt install -y python3.10 && \
    apt install -y neofetch 
```

### Inside we have multiple options to setup our owm image. In our example we take the `ubuntu:22.04` image as a base and use `/home/` as our working directory. In the next step docker will copy everything it finds under the `/home/ace/Documents` directory and copies it into the home folder. Note that the `.` here denotes the `/home/` directory inside the container since we set the working directory with `WORKDIR /home/`. And finally it runs `update` and installs `vim`, `python3.10`, and of course `neofetch`. :hot_face:

### That was a **LOT** of stuff but if you are interested in the possibilities of the `DOCKERFILE` is highly recommend the [DOCKER DOCS](https://docs.docker.com/reference/dockerfile/). :nerd_face:

### After we made our `DOCKERFILE` we can build our image

```bash
docker build -t <name tag> <path to DOCKERFILE>
```

### For example we could to something like 

```bash
docker build -t my_first_image .
```

### Here we are already at the position of the `DOCKERFILE` hence the `.`

### We can check after building our images by

```bash
docker images
```

### We should see something like this

```bash
my_first_image   latest    032aa981f509   17 minutes ago   397MB
ubuntu           20.04     5f5250218d28   3 weeks ago      72.8MB
hello-world      latest    d2c94e258dcb   14 months ago    13.3kB
```

### Now we can run our Docker Container as usual with

```bash
docker run -itd my_first_image
```

### and check again with the `docker ps -a`

```bash
1924b893301b   my_first_image   "/bin/bash"   4 seconds ago       Up 4 seconds                          reverent_wozniak
15f76074d4b8   ubuntu:20.04     "/bin/bash"   About an hour ago   Exited (0) 38 minutes ago             serene_bohr
67476b94c5b2   hello-world      "/hello"      8 hours ago         Exited (0) 33 minutes ago             angry_banach
```

### We successfully build our own Docker Container with its starting features and installations as easy as pie :pie:
