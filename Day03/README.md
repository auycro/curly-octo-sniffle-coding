#MEANSTACK
####Prepare
prepare Ubuntu's vagrant box
```shell
$ vagrant init {box_name}
$ vagrant up
```

install node
```shell
$ sudo apt-get install nodejs
$ ln -s /usr/bin/nodejs /usr/bin/node
```

install npm
```shell
$ sudo apt-get install npm
```

test running node and npm
```shell
$ node -v
$ npm -v
```

install express generator
```shell
$ sudo npm install express-generator -g
```

install mongodb <br/>
[I follow this guide!!](https://docs.mongodb.com/v3.0/tutorial/install-mongodb-on-ubuntu/)

####Create project
```shell
$ express {project-name}
$ cd {project-name}
```

When I try to download mongoose, I found error about symlink [ref](http://askubuntu.com/questions/269727/npm-errors-when-installing-packages-on-windows-share)
```shell
$ npm install --no-bin-links
```
