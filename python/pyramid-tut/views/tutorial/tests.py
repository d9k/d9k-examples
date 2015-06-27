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
        self.assertEqual(responce.status_code, 200)
        self.assertIn(b'Visit', responce.body)

    def test_hello_world(self):
        from .views import hello

        request = testing.DummyRequest()
        responce = hello(request)
        self.assertEqual(responce.status_code, 200)
        self.assertIn(b'Go back', responce.body)

class TutorialFunctionalTests(unittest.TestCase):
    def setUp(self):
        from tutorial import main
        app = main({})
        from webtest import TestApp

        self.testApp = TestApp(app)

    def test_home(self):
        res = self.testApp.get('/', status=200)
        self.assertIn(b'<body>Visit', res.body)

    def test_hello(self):
        res = self.testApp.get('/howdy', status=200)
        self.assertIn(b'<body>Go back', res.body)