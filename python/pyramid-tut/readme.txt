#http://flask.pocoo.org/docs/0.10/tutorial/
http://docs.pylonsproject.org/projects/pyramid/en/latest/quick_tutorial/requirements.html

installation:

	virtualenv -p $(which python3.4) venv
	source venv/bin/activate

проверка после `source venv/bin/activate`:

	which python
	python --version
	which easy_install

установка зависимостей:

	easy_install "pyramid==1.5.7"
	easy_install nose webtest deform sqlalchemy pyramid_chameleon pyramid_debugtoolbar waitress pyramid_tm zope.sqlalchemy

http://docs.pylonsproject.org/projects/pyramid/en/latest/quick_tutorial/scaffolds.html

	hash -r
	pcreate --scaffold starter scaffolds
	cd scaffolds
	python setup.py develop
	pserve development.ini --reload

#Server run (after /venv/bin/activate !):
#python flaskr.py

jinja2: in more_view_classes tutorial