#from pyramid.response import Response
from pyramid.view import view_config

@view_config(route_name='home', renderer='home.mako')
def home(requset):
    return {'name': 'Home View'}

@view_config(route_name='hello', renderer='home.mako')
def hello(request):
    return {'name': 'Hello View'}
