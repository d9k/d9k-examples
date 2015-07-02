from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy
from .security import groupfinder

from pyramid.config import Configurator

# WTF?!?!
#
# AttributeError: 'NoneType' object has no attribute '__context__'
#
#import sys
#sys.path.insert(1, '/home/d9k/.IntelliJIdea14/config/plugins/python/helpers/pycharm')
#sys.path.insert(1, '/home/d9k/.IntelliJIdea14/config/plugins/python/helpers/pydev')
#import pydevd
# pydevd.settrace('localhost', port=1278, stdoutToServer=True, stderrToServer=True)

def main(global_config, **settings):
    config = Configurator(settings=settings)
    config.include('pyramid_jinja2')

    #security policy
    authn_policy = AuthTktAuthenticationPolicy(
        settings['tutorial.secret'], callback=groupfinder,
       hashalg='sha512')

    authz_policy = ACLAuthorizationPolicy()
    config.set_authentication_policy(authn_policy)
    config.set_authorization_policy(authz_policy)

    config.add_route('home', '/')
    config.add_route('hello', '/howdy')
    config.add_route('login', '/login')
    config.add_route('logout', '/logout')
    config.scan('.views')

    return config.make_wsgi_app()
