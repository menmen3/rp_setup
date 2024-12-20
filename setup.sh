#!/bin/bash
sudo apt update
sudo apt install libusb-1.0-0 libusb-1.0-0-dev libpcsclite-dev pcscd pcsc-tools libccid libnfc-bin libnfc-dev cmake
sudo apt install git
sudo apt-get install build-essential libboost-all-dev
# 音声再生のため
sudo apt install libportaudio2 libportaudiocpp0 portaudio19-dev 
# Github CLI
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
&& sudo apt install python3-gst-1.0

sudo systemctl enable pcscd
sudo systemctl start pcscd

gh auth login
# リポジトリをクローン
gh repo clone menmen3/facerecognition

cd facerecognition

wget http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2
bzip2 -d shape_predictor_68_face_landmarks.dat.bz2

# 仮想環境作成
python3 -m venv venv
# 仮想環境に入る
. venv/bin/activate

sudo chown -R $USER venv/

# NFC
pip install pyscard

# 音声
pip install sounddevice soundfile  

# 顔認証
pip install opencv-python
pip install dlib --use-pep517
pip install face-recognition
# https://github.com/ageitgey/face_recognition/issues/608
pip install setuptools

# 仮想環境から出る
deactivate
