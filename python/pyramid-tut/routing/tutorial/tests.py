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
        request.matchdict['first'] = 'First'
        request.matchdict['last'] = 'Last'
        inst = TutorialViews(request)
        response = inst.home()
        # Our view now returns data
        self.assertEqual(response['first'], 'First')
        self.assertEqual(response['last'], 'Last')

class TutorialFunctionalTests(unittest.TestCase):
    def setUp(self):
        from tutorial import main
        app = main({})
        from webtest import TestApp

        self.testApp = TestApp(app)

    def test_home(self):
        res = self.testApp.get('/howdy/Jane/Doe', status=200)
        self.assertIn(b'Jane', res.body)
        self.assertIn(b'Doe', res.body)
