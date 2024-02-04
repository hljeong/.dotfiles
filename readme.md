# .dotfiles

## Installation

```sh
cd
sudo apt update -y
sudo apt install -y git
git clone https://github.com/hljeong/.dotfiles.git
bash .dotfiles/install
su $(whoami)
# acquire ngrok api key and save to $HOME/.config/ngrok/server.key
```

## Install server package

```sh
cd
.dotfiles/install-server
# find authtoken at https://dashboard.ngrok.com/get-started/your-authtoken
ngrok config add-authtoken <token>
```
