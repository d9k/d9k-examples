import falcon
import images
import os

# run as `gunicorn -e PYCHARM_DEBUG=1 --reload app` to debug in PyCharm
if os.environ.get('PYCHARM_DEBUG'):
     import pydevd
     pydevd.settrace('localhost', port=6000, stdoutToServer=True, stderrToServer=True, suspend=False)

api = application = falcon.API()

storage_path = 'img'

image_collection = images.Collection(storage_path)
image = images.Item(storage_path)

api.add_route('/images', image_collection)
api.add_route('/images/{name}', image)
