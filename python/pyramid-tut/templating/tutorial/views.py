#from pyramid.response import Response
from pyramid.view import view_config

@view_config(route_name='home', renderer='home.pt')
def home(requset):
    return {'name': 'Home View'}

@view_config(route_name='hello', renderer='home.pt')
def hello(request):
    return {'name': 'Hello View'}
