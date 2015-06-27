import unittest

from pyramid import testing

# execute `nosetests tutorial`

class TutorialViewTests(unittest.TestCase):
    def setUp(self):
        self.config = testing.setUp()

    def tearDown(self):
        testing.tearDown()

    def test_hello(self):
        from tutorial import hello_world

        request = testing.DummyRequest()
        responce = hello_world(request)
        self.assertEqual(responce.status_code, 200)

class TutorialFunctionalTests(unittest.TestCase):
    def setUp(self):
        from tutorial import main
        app = main({})
        from webtest import TestApp

        self.testApp = TestApp(app)

    def test_hello(self):
        res = self.testApp.get('/', status=200)
        self.assertIn(b'<h1>Hello World!</h1>', res.body)