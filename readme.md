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
dot use server
# find authtoken at https://dashboard.ngrok.com/get-started/your-authtoken
ngrok config add-authtoken <token>
```

## install client package

```sh
cd
dot use client
# acquire ngrok api key and save to $HOME/.config/ngrok/server.key
```

## usage

to use packages, run
```sh
dot use [packages]
```

to stop using a package, run
```sh
dot rm [packages]
```

to list packages currently in use, run
```sh
dot ls
```
