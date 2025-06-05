import logging
import os
from logging.handlers import RotatingFileHandler
from flask import jsonify

def setup_logging(app):
    log_folder = app.config.get('LOG_FOLDER')
    log_file = app.config.get('LOG_FILE')
    os.makedirs(log_folder, exist_ok=True)
    file_handler = RotatingFileHandler(log_file, maxBytes=1024*1024, backupCount=5)
    file_handler.setLevel(logging.INFO)
    formatter = logging.Formatter('[%(asctime)s] %(levelname)s in %(module)s: %(message)s')
    file_handler.setFormatter(formatter)
    app.logger.addHandler(file_handler)
    # Also log to console
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_handler.setFormatter(formatter)
    app.logger.addHandler(console_handler)
    app.logger.setLevel(logging.INFO)

def register_error_handlers(app):
    @app.errorhandler(400)
    def bad_request(e):
        return jsonify(error='Bad request'), 400
    @app.errorhandler(401)
    def unauthorized(e):
        return jsonify(error='Unauthorized'), 401
    @app.errorhandler(403)
    def forbidden(e):
        return jsonify(error='Forbidden'), 403
    @app.errorhandler(404)
    def not_found(e):
        return jsonify(error='Not found'), 404
    @app.errorhandler(500)
    def server_error(e):
        return jsonify(error='Server error'), 500
