http://falcon.readthedocs.org/en/latest/user/tutorial.html
http://falcon.readthedocs.org/en/latest/user/install.html#install

virtualenv -p $(which python3.4) look/venvv
. venv/bin/activate
pip install --upgrade cython falcon gevent uwsg gunicorn
sudo apt-get install httpie
gunicorn --reload app