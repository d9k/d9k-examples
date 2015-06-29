import unittest

from pyramid import testing

# execute as `nosetests tutorial`

class TutorialViewTests(unittest.TestCase):
    def setUp(self):
        self.config = testing.setUp()

    def tearDown(self):
        testing.tearDown()

    def test_home(self):
        from .views import TutorialViews

        request = testing.DummyRequest()
        inst = TutorialViews(request)
        response = inst.home()
        # Our view returns data
        self.assertIn('Home View', response['page_title'])

class TutorialFunctionalTests(unittest.TestCase):
    def setUp(self):
        from tutorial import main
        app = main({})
        from webtest import TestApp

        self.testApp = TestApp(app)

    def test_home(self):
        res = self.testApp.get('/', status=200)
        self.assertIn(b'TutorialViews - Home View', res.body)
