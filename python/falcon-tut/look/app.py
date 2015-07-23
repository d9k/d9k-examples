import falcon
import images

# import sys
# sys.path.insert(1, '/home/d9k/.IntelliJIdea15/config/plugins/python/helpers/pycharm')
# sys.path.insert(1, '/home/d9k/.IntelliJIdea15/config/plugins/python/helpers/pydev')
# import pydevd
# pydevd.settrace('localhost', port=8000, stdoutToServer=True, stderrToServer=True)


api = application = falcon.API()

storage_path = 'img'

image_collection = images.Collection(storage_path)
image = images.Item(storage_path)

api.add_route('/images', image_collection)
api.add_route('/images/{name}', image)
