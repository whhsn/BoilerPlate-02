from flask import Blueprint, request, jsonify, session
from flask_login import login_user, logout_user, login_required, current_user
from ..models import User, db
from .. import login_manager
from werkzeug.security import check_password_hash

auth_bp = Blueprint('auth', __name__)

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    user = User.query.filter_by(username=data.get('username')).first()
    if user and user.check_password(data.get('password')):
        login_user(user)
        return jsonify({"user": {"id": user.id, "username": user.username, "role": user.role}}), 200
    return jsonify({"error": "Invalid credentials"}), 401

@auth_bp.route('/logout', methods=['POST'])
@login_required
def logout():
    logout_user()
    return jsonify({"message": "Logged out"}), 200

@auth_bp.route('/me', methods=['GET'])
@login_required
def me():
    user = current_user
    return jsonify({"user": {"id": user.id, "username": user.username, "role": user.role}}), 200
