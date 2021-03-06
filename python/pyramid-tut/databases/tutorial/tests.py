import unittest
import transaction

from pyramid import testing

# execute as `nosetests tutorial`

def _initTestingDb():
    from sqlalchemy import create_engine
    from .models import (
        DBSession,
        Page,
        Base
    )
    engine = create_engine('sqlite://')
    Base.metadata.create_all(engine)
    DBSession.configure(bind=engine)
    with transaction.manager:
        model = Page(title='FrontPage', body='This is the front page')
        DBSession.add(model)
    return DBSession

class WikiViewTests(unittest.TestCase):
    def setUp(self):
        self.session = _initTestingDb()
        self.config = testing.setUp()

    def tearDown(self):
        self.session.remove()
        testing.tearDown()

    def test_wiki_view(self):
        from .views import WikiViews

        request = testing.DummyRequest()
        inst = WikiViews(request)
        response = inst.wiki_view()
        # Our view now returns data
        self.assertEqual('Wiki View', response['title'])

class WikiFunctionalTests(unittest.TestCase):
    def setUp(self):
        from pyramid.paster import get_app
        app = get_app('development.ini')
        from webtest import TestApp
        self.testApp = TestApp(app)

    def tearDown(self):
        from .models import DBSession
        DBSession.remove()

    def test_it(self):
        res = self.testApp.get('/', status=200)
        self.assertIn(b'Wiki: View', res.body)
        res = self.testApp.get('/add', status=200)
        self.assertIn(b'Add/Edit', res.body)
