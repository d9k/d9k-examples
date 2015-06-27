import unittest

from pyramid import testing

# execute `nosetests tutorial`

class TutorialViewTests(unittest.TestCase):
    def setUp(self):
        self.config = testing.setUp()

    def tearDown(self):
        testing.tearDown()

    def test_hello_world(self):
        from tutorial import hello_world

        request = testing.DummyRequest()
        responce = hello_world(request)
        self.assertEqual(responce.status_code, 200)