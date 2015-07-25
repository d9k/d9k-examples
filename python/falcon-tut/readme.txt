http://falcon.readthedocs.org/en/latest/user/tutorial.html
http://falcon.readthedocs.org/en/latest/user/install.html#install

virtualenv -p $(which python3.4) look/venv
cd look
. venv/bin/activate
pip install --upgrade cython falcon gevent uwsgi gunicorn
sudo apt-get install httpie
easy_install ~/.IntelliJIdea15/config/plugins/python/pycharm-debug-py3k.egg
gunicorn -e PYCHARM_DEBUG=1 --reload app