#from pyramid.response import Response
from pyramid.view import (
    view_config,
    view_defaults
)

@view_defaults(renderer='home.mako')
class TutorialViews:
    def __init__(self, request):
        self.request = request

    @view_config(route_name='home')
    def home(self):
        first = self.request.matchdict['first']
        last = self.request.matchdict['last']
        return {
            'name': 'Home View',
            'first': first,
            'last': last
        }
