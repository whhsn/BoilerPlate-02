import pytest
from app import create_app, db
from app.models import User
from flask import url_for

@pytest.fixture
def client():
    app = create_app()
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    with app.test_client() as client:
        with app.app_context():
            db.create_all()
            user = User(username='testuser', role='user')
            user.set_password('testpass')
            db.session.add(user)
            db.session.commit()
        yield client


def test_login_logout(client):
    # Test login
    response = client.post('/api/auth/login', json={
        'username': 'testuser',
        'password': 'testpass'
    })
    assert response.status_code == 200
    # Test get current user
    response = client.get('/api/auth/me')
    assert response.status_code == 200
    # Test logout
    response = client.post('/api/auth/logout')
    assert response.status_code == 200
