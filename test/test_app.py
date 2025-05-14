import sys
import os
import pytest
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_time_route_not_zero(client):
    response = client.get('/time')
    assert response.status_code == 200
    data = response.get_json()
    assert data["time"] != 0
