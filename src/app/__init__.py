#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
from flask import Flask, jsonify

def create_app():
    app = Flask(__name__)

    @app.route('/')
    def hello_world():
        return 'Moe Flask приложение в контейнере Docker.'

    @app.route('/env')
    def get_env():
        return jsonify({
            'http_proxy': os.environ.get('http_proxy'),
            'https_proxy': os.environ.get('https_proxy'),
        })

    return app

