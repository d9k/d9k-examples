#from pyramid.response import Response
from pyramid.view import (
    view_config,
    view_defaults
)

@view_defaults(renderer='home.jinja2')
class TutorialViews:
    def __init__(self, request):
        self.request = request

    @view_config(route_name='home')
    def home(self):
        return {'name': 'Home View'}

    @view_config(route_name='hello')
    @view_config(route_name='hello_json', renderer='json')
    def hello(self):
        return {'name': 'Hello View'}