import falcon

import msgpack

class Resource(object):

    def on_get(self, req, resp):
        #resp.body = '{"message": "Hello world!"}'
        resp.body = msgpack.packb({'message': 'Hello world!'})
        resp.content_type = 'application/msgpack'
        resp.status = falcon.HTTP_200

    def __init__(self, storage_path):
        self.storage_path = storage_path
