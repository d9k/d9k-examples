import falcon
from talons.auth import middleware
from talons.auth import basicauth, httpheader, htpasswd


def getappconfig():
    return dict()


config = getappconfig()

auth_middleware = middleware.create_middleware(
    identify_with=[
        basicauth.Identifier,
        httpheader.Identifier
    ],
    authenticate_with=htpasswd.Authenticator,
    **config
)

app = falcon.API(before=[auth_middleware])