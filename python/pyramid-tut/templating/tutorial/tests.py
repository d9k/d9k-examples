import unittest

from pyramid import testing

# execute `nosetests tutorial`

class TutorialViewTests(unittest.TestCase):
    def setUp(self):
        self.config = testing.setUp()

    def tearDown(self):
        testing.tearDown()

    def test_home(self):
        from .views import home

        request = testing.DummyRequest()
        responce = home(request)
        # Our view now returns data
        self.assertIn('Home View', responce['name'])

    def test_hello(self):
        from .views import hello

        request = testing.DummyRequest()
        responce = hello(request)
        self.assertIn('Hello View', responce['name'])

class TutorialFunctionalTests(unittest.TestCase):
    def setUp(self):
        from tutorial import main
        app = main({})
        from webtest import TestApp

        self.testApp = TestApp(app)

    def test_home(self):
        res = self.testApp.get('/', status=200)
        self.assertIn(b'<h1>Hi Home View', res.body)

    def test_hello(self):
        res = self.testApp.get('/howdy', status=200)
        self.assertIn(b'<h1>Hi Hello View', res.body)