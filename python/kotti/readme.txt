http://kotti.readthedocs.org/en/latest/first_steps/installation.html
http://kotti.readthedocs.org/en/latest/developing/basic/deployment.html

installation:
virtualenv -p $(which python2.7) mysite
cd mysite
. bin/activate
pip install -r https://raw.github.com/Kotti/Kotti/stable/requirements.txt


#Server run (after /venv/bin/activate !):
#python flaskr.py
