from setuptools import setup

requires = [
    'pyramid',
]

setup(name='tutorial',
      install_requites=requires,
      entry_points="""\
      [paste.app_factory]
      main = tutorial:main
      """,
)