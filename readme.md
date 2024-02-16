# .dotfiles

## installation

```sh
cd
sudo apt update -y
sudo apt install -y git
git clone https://github.com/hljeong/.dotfiles.git
bash .dotfiles/install
su $(whoami)
```

## install server package

```sh
cd
.dotfiles/install-server
# find authtoken at https://dashboard.ngrok.com/get-started/your-authtoken
ngrok config add-authtoken <token>
```

## install client package

```sh
cd
.dotfiles/install-client
# acquire ngrok api key and save to $HOME/.config/ngrok/server.key
```

## usage

to use basic configurations, run
```sh
dot use
```

to stop using basic configurations, run
```sh
dot rm
```

to use a package, run
```sh
dot use-<package>
```

to stop using a package, run
```sh
dot rm-<package>
```
